class GamesController < ApplicationController
  def index
    @games = Game.all
  end
  
  def show
    @game = Game.find(params[:id])
  end
  
  def new
    @game = Game.new
    @game.build_red
    @game.build_blue
  end
  
  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game
    else
      render action: :new
    end
  end
  
  private
  def game_params
    params.require(:game).permit({red: [:offense_id, :defense_id, :score]}, {blue: [:offense_id, :defense_id, :score]})
  end
end