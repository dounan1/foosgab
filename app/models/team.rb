class Team
  include Mongoid::Document
  field :score, type: Integer, default: 0
  
  embedded_in :game, inverse_of: :red
  embedded_in :game, inverse_of: :blue  
  belongs_to :offense, class_name: 'Player', inverse_of: nil
  belongs_to :defense, class_name: 'Player', inverse_of: nil
  belongs_to :player, inverse_of: nil

  validates_presence_of :offense, if: :is_team?
  validates_presence_of :defense, if: :is_team?
  validates_presence_of :player, if: :is_solo?
  validates_numericality_of :score

  def players
    is_solo? ? [player] : [offense, defense]
  end
  
  def unique_players?
    is_solo? ? true : players.uniq.length == players.length
  end
  
  def is_solo?
    game.solo
  end

  def is_team?
    !is_solo?
  end
end