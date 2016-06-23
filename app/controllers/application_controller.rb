class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_board

  private

  def set_current_board
    session[:current_board_id] = params[:current_board_id] if params[:current_board_id]
    @current_board = Board.find_by(id: session[:current_board_id])
  end

end
