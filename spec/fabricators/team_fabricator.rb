Fabricator(:team, aliases: [:duo]) do
  offense fabricator: :player
  defense fabricator: :player
  player nil
end

Fabricator(:solo_team, from: :team, aliases: [:solo]) do
  offense nil
  defense nil
  player
end