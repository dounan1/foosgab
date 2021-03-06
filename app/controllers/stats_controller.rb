class StatsController < ApplicationController

  def index
    @games_chart = games_chart
    @average_goals_chart = average_goals_chart
    @wins_share_chart = wins_share_chart
    # @bubble_chart = bubble_chart # this bubble chart makes no sense really
  end
  
  private
  
  def games_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_columns([{ type: 'string', label: 'Player' },
                           { type: 'number', label: 'Wins' },
                           { type: 'number', label: 'Losses' },
                           { type: 'number', label: 'Ties'}])

    Player.all.sort_by { |a| a.wins }.reverse.each do |p|
      data_table.add_row([p.name, p.wins, p.losses, p.ties])
    end
 
    opts = { width: 480, height: 360, title: 'Games', isStacked: true }
    GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
  end

  def average_goals_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_columns([{ type: 'string', label: 'Player' },
                           { type: 'number', label: 'Avg. Goals'}])

    Player.all.sort { |a,b| b.average_score <=> a.average_score }.each do |p|
      data_table.add_row([p.name, p.average_score])
    end
 
    opts = { width: 480, height: 360, title: 'Average Goals', isStacked: true }
    GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
  end

  def wins_share_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Player')
    data_table.new_column('number', 'Wins')
    
    Player.each do |p|
      data_table.add_row([p.name, p.wins])
    end
 
    opts = { :width => 640, :height => 480, :title => 'Win Share', :is3D => false }
    GoogleVisualr::Interactive::PieChart.new(data_table, opts)
  end

  def bubble_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Player')
    data_table.new_column('number', 'Win %')
    data_table.new_column('number', 'Games')
    data_table.new_column('string', 'Type')
    data_table.new_column('number', 'Avg. Score')
    
    Player.each do |p|
      data_table.add_row([p.name, p.win_pct, p.games.count, p.type, p.average_score])
    end
  
    opts = {
       :width => 800, :height => 500,
       :title => 'Average Score',
       :hAxis => { :title => 'Win %' },
       :vAxis => { :title => 'Games'  },
       :bubble => { :textStyle => { :fontSize => 11 } }
     }
     GoogleVisualr::Interactive::BubbleChart.new(data_table, opts)
  end

end