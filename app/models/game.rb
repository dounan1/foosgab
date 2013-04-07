class Game
  include Mongoid::Document
  field :solo, type: Boolean, default: false

  embeds_one :red, class_name: 'Team', cascade_callbacks: true
  embeds_one :blue, class_name: 'Team', cascade_callbacks: true

  accepts_nested_attributes_for :red, :blue
  
  validate do
    errors.add(:base, errors.generate_message(:base, :error)) unless unique_players?
  end
  
  def players
    red.players + blue.players
  end
  
  def unique_players?
    players.uniq.length == players.length
  end
end