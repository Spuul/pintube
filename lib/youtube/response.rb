module Youtube
  class Response
    def initialize(response)
      @object = response['items'].first
    end

    def identifier
      @object['id']
    end

    def published_at
      snippet['publishedAt']
    end

    def channel_id
      snippet['channelId']
    end

    def title
      snippet['title']
    end

    def description
      snippet['description']
    end

    def thumbnails(size: "default")
      snippet['thumbnails'][size]['url']
    end

    def channel_title
      snippet['channelTitle']
    end

    def category_id
      snippet['categoryId']
    end

    def tags
      snippet['tags']
    end

    private

    def snippet
      @object['snippet']
    end
  end
end
