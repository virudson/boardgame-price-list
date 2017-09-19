# frozen_string_literal: true

class CreateStoreItems < ActiveRecord::Migration[5.1]
  def change
    create_table :store_items do |t|
      t.belongs_to :store, null: false
      t.belongs_to :item, null: false
      t.monetize :price
      t.integer :state, limit: 4, default: 0
      t.string :image_url
      t.text :details
      t.jsonb :source_data, default: {}
      t.datetime :latest_update_at, default: Time.current
      t.timestamps
    end

    add_index :store_items, %w(store_id item_id), unique: true
  end
end
