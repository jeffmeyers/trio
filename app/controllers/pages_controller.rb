class PagesController < ApplicationController
  def index
    @new_game = Game.new
    @new_player = Player.new
  end
end
