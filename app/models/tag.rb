class Tag < ActiveRecord::Base
  validates :name, :video_id, presence: true

  belongs_to :video
end
