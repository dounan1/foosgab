Fabricator(:game, aliases: [:team_game]) do
  red { Fabricate.build(:team) }
  blue { Fabricate.build(:team) }
  date Date.today
  score { rand(11) }
end

Fabricator(:solo_game, from: :game) do
  solo true
  red { Fabricate.build(:solo_team) }
  blue { Fabricate.build(:solo_team) }
  date Date.today
  score { rand(11) }
end