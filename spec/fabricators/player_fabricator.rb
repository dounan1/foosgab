Fabricator(:player) do
  name 'Paul'
  type 'GiveGabber'
  email 'paul@givegab.com'
end

Fabricator(:invalid_player, from: :player) do
  name nil
  type nil
end