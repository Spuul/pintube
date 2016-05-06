module Youtube
  class Request
    include HTTParty

    base_uri 'https://www.googleapis.com'

    def initialize(id, type = 'snippet')
      @options = { query: { id: id, key: ENV['yt_api_key'], part: type } }
    end

    def commit
      self.class.get('/youtube/v3/videos', @options)
    end
  end
end
