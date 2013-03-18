class Team
  include Mongoid::Document
  
  embedded_in :game, inverse_of: :red
  embedded_in :game, inverse_of: :blue  
  belongs_to :offense, class_name: 'Player', inverse_of: nil
  belongs_to :defense, class_name: 'Player', inverse_of: nil
  belongs_to :player, inverse_of: nil

  validates_presence_of :offense, if: :is_team?
  validates_presence_of :defense, if: :is_team?
  validates_presence_of :player, if: :is_solo?
  
  # attr_accessible :offense, :defense, :player
  
  # private
  def is_solo?
    game.solo
  end

  def is_team?
    !is_solo?
  end
end