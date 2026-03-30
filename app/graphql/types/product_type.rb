module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :price, Float, null: true

    def price
      object[:price]   # 🔥 read from custom hash
    end
  end
end