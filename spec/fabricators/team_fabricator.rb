Fabricator(:team, aliases: [:duo]) do
  offense fabricator: :player
  defense fabricator: :player
  player nil
  score { rand(11) }
end

Fabricator(:solo_team, from: :team, aliases: [:solo]) do
  offense nil
  defense nil
  player
end