class Team
  include Mongoid::Document
  include Comparable
  field :score, type: Integer, default: 0
  
  embedded_in :game, inverse_of: :red
  embedded_in :game, inverse_of: :blue  
  belongs_to :offense, class_name: 'Player', inverse_of: nil
  belongs_to :defense, class_name: 'Player', inverse_of: nil
  belongs_to :player, inverse_of: nil

  validates_presence_of :offense, if: :team?
  validates_absence_of  :offense, unless: :team?
  validates_presence_of :defense, if: :team?
  validates_absence_of  :defense, unless: :team?
  validates_presence_of :player, if: :solo?
  validates_absence_of  :player, unless: :solo?

  validates_numericality_of :score, only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10
  validates_presence_of :score

  def players
    solo? ? [player] : [offense, defense]
  end
  
  def unique_players?
    solo? ? true : players.uniq.length == players.length
  end
  
  def solo?
    game.solo
  end

  def team?
    !solo?
  end
  
  def <=>(other)
    self.score <=> other.score
  end
end