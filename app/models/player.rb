class Player
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  slug :name
end