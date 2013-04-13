class Player
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  slug :name

  def games
    Game.all.select { |g| g.players.include? self }.entries
  end

  def wins
    Game.all.select { |g| g.players.include? self }.select { |g| g.winner and g.winner.players.include? self }.count
  end

  def losses
    Game.all.select { |g| g.players.include? self }.select { |g| g.loser and g.loser.players.include? self }.count
  end

  def ties
    Game.all.select { |g| g.players.include? self }.select { |g| g.tie? }.count
  end

  def percentage
    ((wins + 0.5 * ties) / (wins + losses + ties)) * 100
  end

end