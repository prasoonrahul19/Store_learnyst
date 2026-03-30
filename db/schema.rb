# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_27_122856) do
  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "price"
    t.integer "store1_id"
    t.datetime "updated_at", null: false
    t.index ["store1_id"], name: "index_products_on_store1_id"
  end

  create_table "store1s", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "guide_email_at"
    t.integer "owner_id"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_store1s_on_owner_id"
  end

  create_table "store_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "price"
    t.integer "product_id", null: false
    t.integer "store1_id", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_store_products_on_product_id"
    t.index ["store1_id"], name: "index_store_products_on_store1_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "products", "store1s"
  add_foreign_key "store1s", "users", column: "owner_id"
  add_foreign_key "store_products", "products"
  add_foreign_key "store_products", "store1s"
end
