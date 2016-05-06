class Video < ActiveRecord::Base
  validates :identifier,
            :published_at,
            :channel_id,
            :title,
            :description,
            :thumbnail,
            :channel_title,
            :category_id, presence: true
  validates :identifier, uniqueness: true

  has_many :board_videos
  has_many :boards, through: :board_videos
  has_many :tags, dependent: :destroy
end
