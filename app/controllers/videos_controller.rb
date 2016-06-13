class VideosController < ApplicationController
  before_action :set_video, only: [:show, :update, :destroy]

  def index
    @videos = Video.all
  end

  def show
    set_video
    @boards = Board.all

    render layout: nil
  end


  def new
    @video = Video.new url: params[:video_url]
    @video.add_yt_data RetrieveYoutubeData.new(@video.yt_id).call
  end

  def create
    @video = Video.new video_params
    @video.add_yt_data RetrieveYoutubeData.new(@video.yt_id).call

    if @video.save
      redirect_to root_path, notice: 'Video added.'
    else
      redirect_to root_path,  alert: "Video couldn't be added: #{@video.errors.full_messages.join(', ')}"
    end
  end

  def update
    if @video.update_attributes(video_params)
      redirect_to root_path
    end
  end

  def destroy
    set_video

    if @video.destroy
      flash.notice  = 'Video deleted.'
    else
      flash.warning = 'Couldn\'t delete video.'
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
