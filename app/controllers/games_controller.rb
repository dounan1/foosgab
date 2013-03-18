class GamesController < ApplicationController
  def index
    @games = Game.all
  end
  
  def show
    @game = Game.find(params[:id])
  end
  
  def new
    @game = Game.new
    @game.create_red
    @game.create_blue
  end
  
  def create
    @game = Game.create(params[:game])
    redirect_to @game
  end
  
  private
  def games_params
    params.require(:game).permit(:name, :red, :blue)
  end
end