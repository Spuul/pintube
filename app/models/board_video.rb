class BoardVideo < ActiveRecord::Base
  validates :board_id,
            :video_id, presence: true

  belongs_to :board
  belongs_to :video
end
