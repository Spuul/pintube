class Api::V1::BoardsController < ApplicationController
  respond_to :json

  def index
    respond_with Board.all
  end

  def show
    respond_with Board.find(params[:id])
  end

  def create
    board = Board.new(board_params)

    if board.save
      render json: board, status: 201, location: [:api, board]
    else
      render json: { errors: board.errors }, status: 422
    end
  end

  def update
    board = Board.find(params[:id])

    if board.update_attributes(board_params)
      render json: board, status: 200, location: [:api, board]
    else
      render json: { errors: board.errors }, status: 422
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy
    head 200
  end

  private

  def board_params
    params.require(:board).permit(:name, :description)
  end
end
