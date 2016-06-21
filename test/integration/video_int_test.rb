require 'integration/integration_test_helper'

class VideoIntTest < ActionDispatch::IntegrationTest

  def test_index

    videos = all('.video').to_a
    assert_equal 4, videos.length

    # check the ordering + display
    [:nooo_daaamn, :chocolate, :macbook, :tenderlove].map{|v| videos v }.each_with_index do |v, i|
      within videos[i] do
        assert_selector '.video_title', text: v.title
      end
    end

    # change board
    select_board 'Music'
    # we check that the associated videos are displayed
    assert_selector '.video', count: 2
    [:chocolate, :nooo_daaamn].each{|v| assert_selector "##{dom_id(videos(v))}" }


    # try without videos
    Video.delete_all

    visit root_path
    assert_selector '.alert-info', text: 'No videos on this board yet'

    select_board
    assert_selector '.alert-info', text: 'No videos added yet'
  end


  def test_add_video_with_boards

    another_aaron_url = 'https://www.youtube.com/watch?v=7amxsgW2gZs'
    title_snippet     = 'Aaron Patterson'

    # add a video
    within 'form#add_video' do
      find('#video_url').set another_aaron_url
      click_button 'Add'
    end
    assert_selector '.modal-title', text: 'Add Video' # set by js
    within MODAL_BODY_SELECTOR do

      assert_selector '.new_video_title', text: title_snippet
      assert_selector '.video_desc', text: 'DHH'
      # we select 2 boards for the video
      within 'form#new_video' do
        check 'Ruby'
        check 'Music'
        click_button 'Add Video'
      end

    end
    refute_selector MODAL_BODY_SELECTOR
    assert_selector '.alert-success', text: 'Video added.'
    assert_selector '.video .video_title', text: title_snippet

    # verify it is displaying in selected boards
    ['Ruby', 'Music'].each{|bn| select_board_and_assert_video bn, title_snippet }

    # try again with same video url
    within 'form#add_video' do
      find('#video_url').set another_aaron_url
      click_button 'Add'
    end
    within MODAL_BODY_SELECTOR do
      assert_selector '.alert-warning', text: 'already added'
    end
    find(DISMISS_BUTTON).click

    # try again with an invalid URL
    within 'form#add_video' do
      find('#video_url').set 'invalid'
      click_button 'Add'
    end
    within MODAL_BODY_SELECTOR do
      assert_selector '.alert-warning', text: "Couldn't add the video with URL"
    end

  end

  def test_show_and_add_to_boards

    aaron_vid = videos :tenderlove

    within("##{dom_id aaron_vid}") { click_link 'Details' }
    # check the dialog
    assert_selector '.modal-title', text: aaron_vid.title # set by js
    within MODAL_BODY_SELECTOR do
      assert_selector '.video_desc', text: aaron_vid.description
      # assigning boards
      within '.edit_video' do
        check 'Ruby'
        check 'Music'

        click_button 'Assign'
      end
    end
    assert_selector '.alert-success', text: 'Video updated.'

    # verify it is displaying in selected boards
    ['Ruby', 'Music'].each{|bn| select_board_and_assert_video bn, aaron_vid.title }
  end

  def test_destroy
    aaron_vid = videos :tenderlove

    accept_confirm do
      within("##{dom_id aaron_vid}") { click_link 'Delete' }
    end

    refute Video.exists?(aaron_vid.id)
  end

end
