class Game
  include Mongoid::Document
  field :solo, type: Boolean, default: false
  field :date, type: Date

  embeds_one :red, class_name: 'Team', cascade_callbacks: true
  embeds_one :blue, class_name: 'Team', cascade_callbacks: true

  accepts_nested_attributes_for :red, :blue
  validates_presence_of :date
  
  before_create do
    self.date ||= Date.today
  end
  
  validate do
    errors.add(:base, errors.generate_message(:base, :error)) unless unique_players?
  end
  
  def players
    red.players + blue.players
  end
  
  def unique_players?
    players.uniq.length == players.length
  end
  
  def winner
    [red,blue].max unless tie?
  end
  
  def loser
    [red,blue].min unless tie?
  end
  
  def tie?
    red.score == blue.score
  end
  
  def solo?
    solo
  end
end