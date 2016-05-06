class CreateVideo
  def initialize(video)
    @video = video
  end

  def call
    Video.transaction do
      build_video_params.tap do |video|
        video.save!
        CreateTags.new(video.id, @video.tags).call
      end
    end
  end

  private

  def build_video_params
    Video.new(
      identifier: @video.identifier,
      published_at: @video.published_at,
      channel_id: @video.channel_id,
      title: @video.title,
      description: @video.description,
      thumbnail: @video.thumbnails,
      channel_title: @video.channel_title,
      category_id: @video.category_id
    )
  end
end
