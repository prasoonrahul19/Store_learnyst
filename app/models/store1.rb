class Store1 < ApplicationRecord
    belongs_to :owner , class_name: "User"
    has_many :store_products
    has_many :products , dependent: :destroy
end
