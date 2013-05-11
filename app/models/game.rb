class Game
  include Mongoid::Document
  field :solo, type: Boolean, default: false
  field :date, type: Date
  field :red_score
  field :blue_score
  field :player_ids
  
  paginates_per 10

  embeds_one :red, class_name: 'Team', cascade_callbacks: true
  embeds_one :blue, class_name: 'Team', cascade_callbacks: true

  accepts_nested_attributes_for :red, :blue
  validates_presence_of :date
  
  scope :full, -> { Game.or({:red_score => 10}, {:blue_score => 10}) }
  scope :partial, where(:red_score.lt => 10, :blue_score.lt => 10)
  scope :with, ->(player) { where(player_ids: player._id) }
  
  before_create do
    self.date ||= Date.today
  end
  
  before_save do
    # duplicate these on the top level because mongoid has issues with scoping embedded documents
    self.red_score = red.score
    self.blue_score = blue.score
    self.player_ids = players.map(&:_id)
  end
  
  validate do
    errors.add(:base, errors.generate_message(:base, :unique_players)) unless unique_players?
  end
  
  def players
    red.players + blue.players
  end
  
  def unique_players?
    players.uniq.length == players.length unless red.nil? || blue.nil?
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

  def offenses
    [red.offense, blue.offense]
  end

  def defenses
    [red.defense, blue.defense]
  end
  
  def team_with_player(player)
    (red.players.include?(player) ? red : blue) unless red.nil? || blue.nil?
  end

  def partner_for(player)
    team_with_player(player).partner(player) if !solo && players.include?(player)
  end

  def opponents_for(player)
    if players.include?(player)
      team = team_with_player(player)
      team == red ? blue.players : red.players
    end
  end
end