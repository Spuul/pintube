class BoardSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :videos
end
