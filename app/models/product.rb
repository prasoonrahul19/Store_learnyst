class Product < ApplicationRecord
    validates :name, presence: true
  
    has_many :store_products
    has_many :store1s, through: :store_products
  end