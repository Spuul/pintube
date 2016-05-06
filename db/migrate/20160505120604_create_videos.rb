class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :identifier, null: false, unique: true
      t.datetime :published_at, null: false
      t.string :channel_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.string :thumbnail, null: false
      t.string :channel_title, null: false
      t.string :category_id, null: false

      t.timestamps
    end
  end
end
