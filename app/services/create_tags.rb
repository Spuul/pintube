class CreateTags
  def initialize(video_id, tags)
    @video_id = video_id
    @tags = tags
  end

  def call
    @tags.each do |tag|
      Tag.new(video_id: @video_id, name: tag).save
    end
  end
end
