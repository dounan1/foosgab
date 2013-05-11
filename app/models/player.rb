class Player
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  field :email, type: String
  field :avatar_url, type: String
  field :type, type: String
  field :uid, type: String

  slug :name

  validates_presence_of :name, :type

  def games
    # move this to a game scope
    # then scope the rest of win/loss/etc as well
    Game.or({ "red.player_id" => _id }, { "red.offense_id" => _id }, { "red.defense_id" => _id },
      { "blue.player_id" => _id }, { "blue.offense_id" => _id }, { "blue.defense_id" => _id })
    # Game.with(self)
  end
  
  def games_won
    games.select { |g| g.winner and g.winner.players.include? self }
  end
  
  def games_lost
    games.select { |g| g.loser and g.loser.players.include? self }
  end
  
  def games_tied
    games.select { |g| g.tie? }
  end

  def wins
    games_won.count
  end

  def losses
    games_lost.count
  end

  def ties
    games_tied.count
  end

  def solo_games
    games.select { |g| g.solo? }
  end
  alias_method :games_as_solo, :solo_games
  alias_method :games_as_player, :solo_games

  def team_games
    games.reject { |g| g.solo? }
  end

  def games_as_offense
    games.select { |g| g.offenses.include? self }
  end
  
  def games_as_defense
    games.select { |g| g.defenses.include? self }
  end

  def win_pct
    num = BigDecimal.new(wins + 0.5 * ties, 5)
    den = BigDecimal.new(wins + losses + ties).nonzero? || 1
    (num / den).round(2)
  end
  
  def average_score
    total = BigDecimal.new(games.inject(0) { |sum,g| sum + g.team_with_player(self).score })
    played = BigDecimal.new(games.count).nonzero? || 1
    (total / played).round(2)
  end

  def games_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_columns([{ type: 'string', label: 'Type' },
                            { type: 'number', label: 'Games' }])

    data_table.add_row(['Wins', self.wins])
    data_table.add_row(['Losses', self.losses])
    data_table.add_row(['Ties', self.ties])
 
    opts = { width: 480, height: 360, title: 'Games' }
    GoogleVisualr::Interactive::PieChart.new(data_table, opts)
  end

end