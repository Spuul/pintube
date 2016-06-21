class RetrieveYoutubeData

  YT_VIDEO_ENDPOINT     = 'https://www.googleapis.com/youtube/v3/videos'
  CACHE_NAMESPACE       = 'yt_video_api'

  def initialize video_id
    @video_id = video_id
  end

  def call
    # we cache the retrieved data for a while
    response = Rails.cache.fetch @video_id, expires_in: 5.minutes, namespace: CACHE_NAMESPACE do
      yt_api_call
    end

    if response['items'].empty?
      raise ArgumentError, 'Not found'
    else
      response['items'].first
    end
  end


  private
  def yt_api_call
    raw_response = RestClient.get YT_VIDEO_ENDPOINT, params:
        {
            key: Rails.application.secrets.youtube_api_key,
            part: 'snippet',
            id: @video_id
        }
    JSON.parse raw_response
  end
end