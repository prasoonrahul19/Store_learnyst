# class AddOwnerToStores < ActiveRecord::Migration[8.1]
#   def change
#     add_reference :store1s, :Owner, foreign_key: { to_table: :users }
#   end
# end