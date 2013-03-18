class Game
  include Mongoid::Document
  field :solo, type: Boolean, default: false

  embeds_one :red, class_name: 'Team'
  embeds_one :blue, class_name: 'Team'

  accepts_nested_attributes_for :red, :blue
end