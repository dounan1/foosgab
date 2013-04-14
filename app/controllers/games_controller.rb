class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.order_by(date: :desc).page params[:page]
  end
  
  def show
    @game = Game.find(params[:id])
  end
  
  def new
    @game = Game.new
    @game.build_red and @game.build_blue
  end
  
  def create
    @game = Game.new(game_params)
    @game.save ? redirect_to(@game) : render(action: :new)
  end
  
  def edit
    @game = Game.find(params[:id])
  end
  
  def update
    if @game.update_attributes(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path
  end
  
  private
  
  def set_game
    @game = Game.find(params[:id])
  end
  
  def game_params
    params[:game][:solo] = (params[:game][:solo] == "1" ? true : false)

    if params[:game][:solo]
      params[:game][:red][:player_id] = params[:game][:red][:offense_id]
      params[:game][:blue][:player_id] = params[:game][:blue][:offense_id]
      params[:game][:red].delete(:offense_id) and params[:game][:red].delete(:defense_id)
      params[:game][:blue].delete(:offense_id) and params[:game][:blue].delete(:defense_id)
    end

    params.require(:game).permit(:solo, :date,
      {red: [:offense_id, :defense_id, :player_id, :score]},
      {blue: [:offense_id, :defense_id, :player_id, :score]})
  end

end