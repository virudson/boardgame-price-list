class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :slug
      t.string :image_url
      t.datetime :release_date
      t.timestamps
    end
  end
end
