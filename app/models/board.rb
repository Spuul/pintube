class Board < ActiveRecord::Base

  # Relationships ==================================================================
  has_and_belongs_to_many :videos

  # Scopes =========================================================================
  scope :default_order, ->{ order(:name) }
  # Behaviours =====================================================================

  # Callbacks ======================================================================
  before_validation {|b| b.name = b.name.squish.titleize if b.name}

  # Validations ====================================================================
  validates_presence_of :name
  validates_uniqueness_of :name

end
