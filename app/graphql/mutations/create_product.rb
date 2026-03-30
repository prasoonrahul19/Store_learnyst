module Mutations
  class CreateProduct < BaseMutation
    argument :store1_id, ID, required: true
    argument :name, String, required: true

    field :product, Types::ProductType, null: true
    field :errors, [String], null: false

    def resolve(store1_id:, name:)
      store = Store1.find_by(id: store1_id)
      raise GraphQL::ExecutionError, "Store not found" unless store

      product = store.products.new(name: name)

      if product.save
        { product: product, errors: [] }
      else
        { product: nil, errors: product.errors.full_messages }
      end
    end
  end
end