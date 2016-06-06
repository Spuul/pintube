class Video < ActiveRecord::Base

  # src: http://stackoverflow.com/a/6557092/178266
  YT_URL_VIDEO_ID_REGEX = /(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/

  # Relationships ==================================================================
  has_and_belongs_to_many :boards

  # Scopes =========================================================================

  # Behaviours =====================================================================
  enum status: [:watched, :faved]
  store :yt_data, coder: JSON #, accessors: [ :color, :homepage ]

  # Callbacks ======================================================================

  # Validations ====================================================================
  validates_presence_of :url
  validates_uniqueness_of :url


  ###### Youtube data Interface
  # for now, we interface with the Youtube response data.
  # In the future, as needed (speed or searchability), we can convert data to full-blown attributes

  def set_yt_data data
    self.yt_data = data
  end

  def yt_id
    yt_data.try(:fetch, 'id') do
      Regexp.last_match[1] if url && url.match(YT_URL_VIDEO_ID_REGEX)
    end
  end

  def title
    yt_data_hash['title']
  end
  def description
    yt_data_hash['description']
  end
  def tags
    yt_data_hash['tags']
  end
  # etc...
  def thumbnail_url
    # we can replace this ugly try chain with dig under ruby 2.3
    #@todo? expose thumbnail size
    yt_data_hash.try(:[], 'thumbnails').try(:[], 'medium').try(:[], 'url')
  end


  private

  def yt_data_hash
    yt_data.try(:fetch, 'snippet', {})
  end

end
