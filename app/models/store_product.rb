class StoreProduct < ApplicationRecord
  belongs_to :store1
  belongs_to :product

  validates :product_id, uniqueness: { scope: :store1_id }
  validates :price, presence: true
end