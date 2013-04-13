class Player
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  slug :name

  def percentage
    ((wins + 0.5 * ties) / (wins + losses + ties)) * 100
  end

  def games
    # move this to a game scope
    # then scope the rest of win/loss/etc as well
    Game.or({ "red.player_id" => _id }, { "red.offense_id" => _id }, { "red.defense_id" => _id },
      { "blue.player_id" => _id }, { "blue.offense_id" => _id }, { "blue.defense_id" => _id })
    # Game.or(Hash[["red.player_id", "red.offense_id", "red.defense_id", "blue.player_id", "blue.offense_id", "blue.defense_id"].map {|k| [k,_id]}])
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

end