require 'integration/integration_test_helper'

class BoardIntTest < ActionDispatch::IntegrationTest

  def test_index_current_board

    # no board
    refute_selector '.board_header'

    # changing board
    select_board 'Music'
    assert_selector '.board_header .board_title', text: 'Music'

    # walk out and back to see if current board is persisted
    visit 'http://google.com'
    visit root_path
    assert_selector '.board_header .board_title', text: 'Music'

    # make sure we clear the current board by selecting 'All Videos'
    select_board
    refute_selector '.board_header'
    visit 'http://google.com'
    visit root_path
    refute_selector '.board_header'
  end

  def test_create_edit_delete

    board_name = 'My Board'

    # create a new board
    within 'form#new_board' do
      fill_in 'board_name', with: board_name
      click_button 'Create'
    end
    assert_selector '.alert-success', text: "Board #{board_name} created."

    # select it
    select board_name
    assert_selector '.alert-info', text: 'No videos on this board yet'

    # rename it
    within '.board_header' do
      assert_selector '.board_title', text: board_name
      board_name += '2'
      fill_in 'board_name', with: board_name
      click_button 'Rename This Board'
    end
    assert_selector '.alert-success'
    assert_selector '.board_title', text: board_name

    # assign a video to it
    aaron = videos :tenderlove
    board = Board.find_by! name: board_name
    board.videos << aaron

    visit root_path
    assert_selector ".video##{dom_id aaron}"

    # delete it
    within('form.edit_board') do
      accept_confirm { click_link 'Delete' }
    end

    assert_selector '.alert-success', text: "Board #{board_name} deleted."

    # checking DB
    refute Board.exists?(board.id)
    refute_includes aaron.reload.boards, board
  end

end