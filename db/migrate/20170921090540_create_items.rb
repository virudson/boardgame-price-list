class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :slug
      t.string :thumbnail
      t.string :image
      t.integer :genre, limit: 4, default: 0
      t.integer :min_players, default: 1
      t.integer :max_players, default: 1
      t.integer :min_play_time
      t.integer :max_play_time
      t.integer :min_age
      t.date :release_date
      t.jsonb :categories, default: {}
      t.jsonb :publishers, default: {}
      t.jsonb :source_data, default: {}
      t.timestamps
    end
  end
end
