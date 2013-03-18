class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    @players = Player.all
  end

  def show
    #
  end

  def new
    @player = Player.new
  end

  def edit
    #
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @player.update(player_params)
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @player.destroy
    redirect_to players_url, notice: 'Player was successfully destroyed.'
  end

  private
  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    # params.require(:player).permit(:name)
    params.require(:player).permit!
    # params.permit!
  end
end