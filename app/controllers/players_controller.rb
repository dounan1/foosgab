class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    @players = Player.all.asc(:name)
  end

  def show
    @games = @player.games.order_by(date: :desc).page params[:page]
    @games_chart = @player.games_chart
  end

  def new
    @player = Player.new
  end

  def edit
    #
  end

  def create
    @player = Player.new(player_params)
    authorize! :create, @player

    if @player.save
      redirect_to players_path, notice: 'Player was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    authorize! :update, @player
    if @player.update_attributes(player_params)
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize! :destroy, @player
    session.delete(:player_id) if current_user = @player
    @player.destroy
    redirect_to players_url, notice: 'Player was successfully destroyed.'
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :type)
  end
end