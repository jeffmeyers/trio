class GamesController < ApplicationController
  def create
    game = Game.create!
    player = game.players.create!(params.require(:player).permit(:name))
    join_game(game.id, player.id)
    redirect_to game_path(game)
  end

  def start
    game = Game.find(params[:id])
    game.start
    redirect_to game_path(game)
  end

  def action
    game = Game.find(params[:id])
    action = Action.new(
      type: params[:action_type],
      entity_id: params[:action_entity_id]
    )
    game.apply(action)
    redirect_to game_path(game)
  end

  def show
    @game = Game.includes(:players).find(params[:id])
  end
end
