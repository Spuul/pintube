class VideosController < ApplicationController
  before_action :set_video, only: [:show, :update, :destroy]


  def index

    @videos = if @current_board
                @current_board.videos
              else
                Video.all
              end.default_order.to_a
  end

  def show
    @boards = Board.default_order

    render layout: nil
  end

  def new
    @video = Video.new url: params[:video_url]
    @video.boards << @current_board if set_current_board

    @boards = Board.default_order

    begin
      @video.add_yt_data RetrieveYoutubeData.new(@video.yt_id).call
    rescue ArgumentError => e
      flash.now['warning'] = "Couldn't add the video with URL: #{@video.url}"
    end
    # The following could be placed before we call yt but here, we have a confirmation that the yt_id is valid
    if flash.now['warning'].nil? && (duplicate = Video.find_by(yt_id: @video.yt_id))
      flash.now['warning'] = "Video already added (#{duplicate.title})."
    end

    render layout: nil
  end

  def create
    @video = Video.new video_params
    @video.add_yt_data RetrieveYoutubeData.new(@video.yt_id).call

    if @video.save
      flash['success'] = 'Video added.'
    else
      flash['warning'] = "Video couldn't be added: #{@video.errors.full_messages.join(', ')}."
    end
    redirect_to root_path
  end

  def update
    if @video.update_attributes(video_params)
      flash['success'] = 'Video updated.'
    end
    redirect_to root_path
  end

  def destroy
    if @video.destroy
      flash['success'] = 'Video deleted.'
    else
      flash['warning'] = 'Couldn\'t delete video.'
    end
    redirect_to root_path
  end



  private

  def video_params
    params.require(:video).permit(:url, board_ids: [])
  end

  def set_video
    @video = Video.find params[:id]
  end
end
