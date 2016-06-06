require 'test_helper'

class BoardTest < ActiveSupport::TestCase

  have_and_belong_to_many(:videos)

  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

end
