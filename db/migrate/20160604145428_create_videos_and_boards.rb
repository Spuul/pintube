class CreateVideosAndBoards < ActiveRecord::Migration
  def change

    create_table :videos do |t|

      t.string :url, null: false

      t.text :yt_data

      t.integer :status, default: 0
      # t.text :tags

      t.timestamps null: false
    end


    create_table :boards do |t|

      t.string :name, null: false

      t.timestamps null: false
    end


    # association join table
    create_table :boards_videos, id: false do |t|

      t.belongs_to :board, index: true, null: false
      t.belongs_to :video, index: true, null: false
    end

  end
end
