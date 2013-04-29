Fabricator(:game, aliases: [:team_game]) do
  red { Fabricate.build(:duo) }
  blue { Fabricate.build(:duo) }
  date Date.today
  score { rand(11) }
end

Fabricator(:solo_game, from: :game) do
  solo true
  red { Fabricate.build(:solo) }
  blue { Fabricate.build(:solo) }
  date Date.today
  score { rand(11) }
end