class Api::V1::VideosController < ApplicationController
  respond_to :json

  def show
    respond_with Video.find(params[:id])
  end

  def index
    respond_with Video.all
  end

  def create
    current_board = Board.find(params[:board_id])
    video = Youtube::Video.new(params[:url]).fetch
    current_board.videos << video

    if current_board.save
      render json: current_board, status: 201
    else
      render json: { errors: current_board.errors }, status: 422
    end
  end

  private

  def video_params
    params.require(:video).permit(:url)
  end
end
