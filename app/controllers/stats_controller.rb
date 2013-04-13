class StatsController < ApplicationController

  def standings
    @wins_chart = wins_chart
    @wins_share_chart = wins_share_chart
    @bubble_chart = bubble_chart
  end
  
  private
  
  def wins_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_columns([{ type: 'string', label: 'Player' },
                           { type: 'number', label: 'Wins' },
                           { type: 'number', label: 'Losses' },
                           { type: 'number', label: 'Ties'}])

    Player.each do |p|
      data_table.add_row([p.name, p.wins, p.losses, p.ties])
    end
 
    opts = { width: 640, height: 480, title: 'Wins', isStacked: true }
    GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
  end

  def average_goals_chart
    
  end

  def wins_share_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Player')
    data_table.new_column('number', 'Hours per Day')
    
    Player.each do |p|
      data_table.add_row([p.name, p.wins])
    end
 
    opts = { :width => 640, :height => 480, :title => 'Win Share', :is3D => false }
    GoogleVisualr::Interactive::PieChart.new(data_table, opts)
  end

  def bubble_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Player')
    data_table.new_column('number', 'Games')
    data_table.new_column('number', 'Win %')
    data_table.new_column('string', 'Type')
    data_table.new_column('number', 'Avg. Score')
    
    Player.each do |p|
      data_table.add_row([p.name, p.games.count, p.win_pct, p.type, p.average_score])
    end
  
    opts = {
       :width => 800, :height => 500,
       :title => 'Average Score',
       :hAxis => { :title => 'games' },
       :vAxis => { :title => 'win%'  },
       :bubble => { :textStyle => { :fontSize => 11 } }
     }
     GoogleVisualr::Interactive::BubbleChart.new(data_table, opts)
  end

end