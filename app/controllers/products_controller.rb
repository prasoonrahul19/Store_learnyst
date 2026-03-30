class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store

  # 🔐 SECURE store access
  def set_store
    @store = current_user.store1s.find_by(id: params[:store1_id])

    render json: { error: "Store not found or unauthorized" }, status: :not_found unless @store
  end

  # GET /store1s/:store1_id/products
  def index
    store_products = @store.store_products.includes(:product)
  
    products = store_products.map do |sp|
      {
        id: sp.product.id,
        name: sp.product.name,
        price: sp.price   # 🔥 correct source
      }
    end
    Rails.logger.info "Response : #{products.to_json}"
    render json: products
  end

  # GET /store1s/:store1_id/products/:id
  def show
    product = @store.products.find_by(id: params[:id])

    if product
      render json: product
    else
      render json: { error: "Product not found in this store" }, status: :not_found
    end
  end

  # POST /store1s/:store1_id/products
  def create
    # 🔥 Step 1: find or create global product
    product = Product.find_or_create_by(name: product_params[:name])
  
    # 🔥 Step 2: create/update join record (store_product)
    store_product = @store.store_products.find_or_initialize_by(product: product)
    store_product.price = product_params[:price]
  
    if store_product.save
      render json: {
        product: product,
        price: store_product.price
      }, status: :created
    else
      render json: store_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH /store1s/:store1_id/products/:id
  def update
    product = @store.products.find_by(id: params[:id])

    if product&.update(product_params)
      render json: product
    else
      render json: { error: "Update failed or wrong store" }, status: :unprocessable_entity
    end
  end

  # DELETE /store1s/:store1_id/products/:id
  def destroy
    product = @store.products.find_by(id: params[:id])

    if product
      @store.products.delete(product)  # 🔥 remove relation only
      render json: { message: "Removed from store" }
    else
      render json: { error: "Product not found in this store" }, status: :not_found
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end