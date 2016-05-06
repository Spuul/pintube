class CreateBoardVideos < ActiveRecord::Migration
  def change
    create_table :board_videos do |t|
      t.references :board, null: false
      t.references :video, null: false

      t.timestamps
    end
    add_index :board_videos, :board_id
    add_index :board_videos, :video_id
  end
end
