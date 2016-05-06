class VideoSerializer < ActiveModel::Serializer
  attributes :id, :identifier, :published_at, :channel_id, :title, :description,
             :thumbnail, :channel_title, :category_id

  has_many :tags
end
