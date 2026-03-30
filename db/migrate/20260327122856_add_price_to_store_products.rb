class AddPriceToStoreProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :store_products, :price, :decimal
  end
end
