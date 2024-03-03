class ApplicationController < ActionController::Base
  before_action :set_current_game_and_player

  def set_current_game_and_player
    @current_game = Game.includes(:players).find_by(id: session[:game_id])
    @current_player = Player.includes(:cards).find_by(id: session[:player_id])
  end

  def join_game(game_id, player_id)
    session[:game_id] = game_id
    session[:player_id] = player_id
  end
end
