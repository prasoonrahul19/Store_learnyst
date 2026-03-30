# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    # ✅ Get all stores of current user
    field :stores, [Types::Store1Type], null: false

    def stores
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Unauthorized" unless user

      user.store1s.includes(:products)
    end

    # ✅ Get products of a specific store (secure)
    field :products, [Types::ProductType], null: false do
      argument :store1_id, ID, required: true
    end

    def products(store1_id:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Unauthorized" unless user
    
      store = user.store1s.find_by(id: store1_id)
      raise GraphQL::ExecutionError, "Store not found or unauthorized" unless store
    
      store.store_products.includes(:product).map do |sp|
        {
          id: sp.product.id,
          name: sp.product.name,
          price: sp.price   # 🔥 from join table
        }
      end
    end

    # 🔹 Node (leave as is)
    field :node, Types::NodeType, null: true do
      argument :id, ID, required: true
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true do
      argument :ids, [ID], required: true
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end
  end
end