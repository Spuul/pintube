class BoardsController < ApplicationController

  def create
    @board = Board.new board_params

    if @board.save
      flash['success'] = "Board #{@board.name} created."
    else
      flash['warning'] = "Couldn't create board #{@board.name}: #{@board.errors.full_messages.join(', ')}."
    end
    redirect_to root_path
  end

  def update
    @board = Board.find params[:id]

    if @board.update_attributes(board_params)
      flash['success'] = "Board #{@board.name} updated."
    else
      flash['danger']  = "Failed updating board #{@board.name}: #{@board.errors.full_messages.join(', ')}."
    end
    redirect_to root_path
  end

  def destroy
    @board = Board.find params[:id]

    if @board.destroy
      flash['success'] = "Board #{@board.name} deleted."
    else
      flash['danger']  = "Failed deleted board #{@board.name}."
    end
    redirect_to root_path
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end
end
