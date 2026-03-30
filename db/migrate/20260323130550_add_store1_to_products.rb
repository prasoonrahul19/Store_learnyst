class AddStore1ToProducts < ActiveRecord::Migration[8.1]
  def change
    add_reference :products, :store1, null: true, foreign_key: true
  end
end
