class CreateStoreProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :store_products do |t|
      t.references :store1, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
