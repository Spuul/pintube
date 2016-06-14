module VideosHelper

  def no_videos_message
    if @current_board
      'No videos on this board yet. Click \'details\' on a video to add it to boards.'
    elsif Video.count == 0
      'No videos added yet. Please add some with the form on the top right.'
    end
  end
end
