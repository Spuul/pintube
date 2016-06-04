require 'test_helper'

class VideoTest < ActiveSupport::TestCase

  should have_and_belong_to_many(:boards)

  should validate_presence_of(:url)
  should validate_uniqueness_of(:url)

  def test_model_setup
  end

end
