class PlayersController < ApplicationController
  def create
    game = Game.find(player_create_params[:game_id])
    player = game.players.create(player_create_params)
    join_game(game.id, player.id)
    redirect_to game_path(game)
  end

  private

  def player_create_params
    params.require(:player).permit(:name, :game_id)
  end
end
