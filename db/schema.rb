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

ActiveRecord::Schema.define(version: 20171102110346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug"
    t.string "thumbnail"
    t.string "image"
    t.integer "genre", default: 0
    t.integer "min_players", default: 1
    t.integer "max_players", default: 1
    t.integer "min_play_time"
    t.integer "max_play_time"
    t.integer "min_age"
    t.date "release_date"
    t.jsonb "categories", default: {}
    t.jsonb "publishers", default: {}
    t.jsonb "source_data", default: {}
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
    t.datetime "latest_update_at", default: "2017-11-02 11:18:11"
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
