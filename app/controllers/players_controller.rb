class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    @players = Player.all.asc(:name)
  end

  def show
    @games = @player.games.order_by(date: :desc).page params[:page]
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
  
  # not done
  def time_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string'  , 'Date')
    data_table.new_column('number'  , 'Win Total')
    data_table.new_column('number' , 'Loss Total')
    data_table.new_column('number' , 'Tie Total')

    @player.games.each do |g|
      # data_table.add_row([ g.date, wins at g.date, losses at g.date, ties at g.date ])
    end
 
    opts   = { :width => 800, :height => 500, :title => "The decline of 'The 39 Steps'", :vAxis => { :title => 'Accumulated Rating'}, :isStacked => true }
    GoogleVisualr::Interactive::SteppedAreaChart.new(data_table, opts)
  end

end