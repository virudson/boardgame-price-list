# frozen_string_literal: true

class CreateStoreItems < ActiveRecord::Migration[5.1]
  def change
    create_table :store_items do |t|
      t.belongs_to :store, null: false
      t.belongs_to :item, null: false
      t.integer :product_id
      t.integer :state, limit: 4, default: 0
      t.boolean :available, default: false
      t.boolean :shipping, default: false
      t.monetize :price, default: 0
      t.monetize :shipping_price, default: 0
      t.integer :weight, default: 0
      t.string :remark
      t.text :details
      t.jsonb :source_data, default: {}
      t.datetime :latest_update_at, default: Time.current
      t.timestamps
    end

    add_index :store_items, %w(store_id item_id), unique: true
    add_index :store_items, %w(store_id product_id), unique: true
  end
end
