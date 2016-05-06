class Board < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :name, uniqueness: true

  has_many :board_videos
  has_many :videos, through: :board_videos
end
