class VideosController < ApplicationController
  before_action :set_video, only: [:show, :update, :destroy]

  #@todo keep current board id in session

  def index
    @current_board = Board.find_by id: params[:current_board_id]

    @videos = if @current_board
                @current_board.videos
              else
                Video.all
              end.default_order.to_a
  end

  def show
    set_video
    @boards = Board.default_order

    render layout: nil
  end


  def new
    @video = Video.new url: params[:video_url]

    begin
      @video.add_yt_data RetrieveYoutubeData.new(@video.yt_id).call
    rescue ArgumentError => e
      redirect_to root_path, flash: {warning: "Couldn't add the video with URL: #{@video.url}"} and return
    end
    # The following could be placed before we call yt but here, we have a confirmation that the yt_id is valid
    if (duplicate = Video.find_by(yt_id: @video.yt_id))
      redirect_to root_path, flash: {warning: "Video already added (#{duplicate.title})."} and return
    end
  end

  def create
    @video = Video.new video_params
    @video.add_yt_data RetrieveYoutubeData.new(@video.yt_id).call

    if @video.save
      redirect_to root_path, flash: {success: 'Video added.'}
    else
      redirect_to root_path, flash: {warning: "Video couldn't be added: #{@video.errors.full_messages.join(', ')}."}
    end
  end

  def update
    if @video.update_attributes(video_params)
      flash['success'] = 'Video updated.'
    end
    redirect_to root_path
  end

  def destroy
    set_video

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
