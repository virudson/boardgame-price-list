# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170921090614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "genre"
    t.string "category"
    t.string "slug"
    t.string "publisher"
    t.datetime "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "store_items", force: :cascade do |t|
    t.bigint "store_id", null: false
    t.bigint "item_id", null: false
    t.integer "product_id"
    t.integer "state", default: 0
    t.boolean "available", default: false
    t.boolean "shipping", default: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "THB", null: false
    t.integer "shipping_price_cents", default: 0, null: false
    t.string "shipping_price_currency", default: "THB", null: false
    t.integer "weight", default: 0
    t.string "remark"
    t.text "details"
    t.jsonb "source_data", default: {}
    t.datetime "latest_update_at", default: "2017-09-23 11:06:03"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_store_items_on_item_id"
    t.index ["store_id", "item_id"], name: "index_store_items_on_store_id_and_item_id", unique: true
    t.index ["store_id", "product_id"], name: "index_store_items_on_store_id_and_product_id", unique: true
    t.index ["store_id"], name: "index_store_items_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.string "initials_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
