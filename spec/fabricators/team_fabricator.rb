Fabricator(:team, aliases: [:duo]) do
  offense fabricator: :player
  defense fabricator: :player
end

Fabricator(:solo_team, from: :team, aliases: [:solo]) do
  player
end