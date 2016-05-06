module Youtube
  class Video
    def initialize(url)
      @identifier = parse(url)
    end

    def fetch
      return existing_video if ::Video.exists?(identifier: @identifier)
      save_video(Request.new(@identifier).commit)
    end

    private

    def parse(url)
      url.match(/(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/)[1]
    end

    def existing_video
      ::Video.find_by_identifier(@identifier)
    end

    def save_video(response)
      CreateVideo.new(Response.new(response)).call
    end
  end
end
