class Video < ActiveRecord::Base

  # src: http://stackoverflow.com/a/6557092/178266
  YT_URL_VIDEO_ID_REGEX = /(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/

  # Relationships ==================================================================
  has_and_belongs_to_many :boards

  # Scopes =========================================================================
  scope :default_order, ->{ order created_at: :desc }

  # Behaviours =====================================================================
  serialize :yt_data, JSON

  # Callbacks ======================================================================

  # Validations ====================================================================
  validates_presence_of :url

  validates :yt_id, presence: true, uniqueness: true

  # Youtube data Interface =========================================================
  # For now, we interface with the Youtube response data.
  # In the future, as needed (speed or searchability), we can convert data to full-blown attributes

  def add_yt_data data
    # Currently we don't do any processing on the data (future proofing)
    self.yt_data = data
    self.yt_id = yt_data.try(:fetch, 'id') # we set the yt_id once yt confirmed it
  end

  def yt_id
    read_attribute(:yt_id) || extract_yt_id_from_url
  end

  def title
    yt_snippet_data['title']
  end
  def description
    yt_snippet_data['description']
  end
  def tags
    yt_snippet_data['tags']
  end
  # etc...
  def thumbnail_url(quality: 'medium')
    yt_snippet_data.dig('thumbnails', quality, 'url')
  end

  def embed_url
    "http://www.youtube-nocookie.com/embed/#{yt_id}?rel=0"
  end

  private

  def yt_snippet_data
    yt_data.try(:fetch, 'snippet') || {}
  end

  def extract_yt_id_from_url
    Regexp.last_match[1] if url && url.match(YT_URL_VIDEO_ID_REGEX)
  end
end
