class CreateStore1s < ActiveRecord::Migration[8.1]
  def change
    create_table :store1s do |t|
      t.string :title
      t.string :address

      t.timestamps
    end
  end
end
