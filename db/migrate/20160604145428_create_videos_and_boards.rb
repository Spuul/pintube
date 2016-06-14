class CreateVideosAndBoards < ActiveRecord::Migration
  def change

    create_table :videos do |t|

      t.string :url, null: false

      t.text :yt_data
      t.string :yt_id, null: false, index: true

      t.timestamps null: false
    end
    add_index :videos, :created_at, order: {created_at: :desc}




    create_table :boards do |t|

      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :boards, :name, order: {name: :asc}




    # association join table
    create_table :boards_videos, id: false do |t|

      t.belongs_to :board, index: true, null: false
      t.belongs_to :video, index: true, null: false

    end

  end
end
