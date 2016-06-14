class RetrieveYoutubeData

  #@todo extract url endpoint / API key

  YT_VIDEO_ENDPOINT     = 'https://www.googleapis.com/youtube/v3/videos'
  YT_API_KEY            = 'AIzaSyACXu_h4CE5xxJkn-1N-2U14I7KYtNSOGQ'
  CACHE_NAMESPACE       = 'yt_video_api'

  def initialize video_id
    @video_id = video_id
  end

  def call
    # we cache the retrieved data for a while
    response = Rails.cache.fetch @video_id, expires_in: 5.minutes, namespace: CACHE_NAMESPACE do
      yt_api_call
    end
    # ap response

    if response['items'].empty?
      raise ArgumentError, 'Not found'
    else
      response['items'].first
    end
  end


  private
  def yt_api_call
    raw_response = RestClient.get YT_VIDEO_ENDPOINT,
                                  params: {key: YT_API_KEY, part: 'snippet', id: @video_id}
    JSON.parse raw_response
  end
end