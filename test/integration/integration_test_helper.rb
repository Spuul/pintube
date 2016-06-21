require 'test_helper'


require 'capybara/rails'
Capybara.default_driver = :webkit

Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
  config.skip_image_loading
end


class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # to use dom_id
  include ActionView::RecordIdentifier

  self.use_transactional_fixtures = false

  def setup
    visit root_path
  end

  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  def teardown
    Capybara.reset_sessions!
    # Capybara.use_default_driver
  end



  #=  helpers  ===========================================

  MODAL_BODY_SELECTOR = '.modal-body'
  DISMISS_BUTTON = 'button.close'

  def select_board name = '- All Videos -'
     select name, from: 'current_board_id', wait: 1
  end

  def select_board_and_assert_video board_name, video_title
    select_board board_name
    assert_selector '.board_title', text: board_name
    assert_selector '.video .video_title', text: video_title
  end
end