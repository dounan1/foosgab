Fabricator(:player) do
  name 'Paul'
  type 'GiveGabber'
end

Fabricator(:invalid_player, from: :player) do
  name nil
  type nil
end