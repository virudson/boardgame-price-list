class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :genre, limit: 4
      t.string :category
      t.string :slug
      t.string :publisher
      t.datetime :release_date
      t.timestamps
    end
  end
end
