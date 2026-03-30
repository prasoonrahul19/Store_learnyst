module Types
    class Store1Type < Types::BaseObject
      field :id, ID, null: false
      field :title, String, null: true
      field :address, String, null: false
      field :price, Integer, null: false
  
      # 🔥 nested products
      field :products, [Types::ProductType], null: false
    end
end