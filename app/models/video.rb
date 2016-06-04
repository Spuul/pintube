class Video < ActiveRecord::Base

  # Relationships ==================================================================
  has_and_belongs_to_many :boards

  # Scopes =========================================================================

  # Behaviours =====================================================================
  enum status: [:watched, :faved]
  # store :yt_data, accessors: [ :color, :homepage ], coder: JSON

  # Callbacks ======================================================================

  # Validations ====================================================================
  validates_presence_of :url
  validates_uniqueness_of :url

  # Class methods ==================================================================

  # Instance methods ===============================================================

  # Initialization =================================================================

end
