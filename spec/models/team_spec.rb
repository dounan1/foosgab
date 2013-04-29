require 'spec_helper'

describe Team do
  let(:one_on_one) { Fabricate(:solo_game) }
  let(:two_on_two) { Fabricate(:team_game) }

  context 'validates' do
    it 'presence of offense when in a team game' do
      two_on_two.red.offense = nil
      expect(two_on_two).to_not be_valid
    end

    it 'presence of defense when in a team game' do
      two_on_two.red.defense = nil
      expect(two_on_two).to_not be_valid
    end

    it 'presence of player when in a solo game' do
      one_on_one.red.player = nil
      expect(one_on_one).to_not be_valid
    end

    it 'absence of offense when in a solo game' do
      one_on_one.red.offense = Fabricate(:player)
      expect(one_on_one).to_not be_valid
    end

    it 'absence of defense when in a solo game' do
      one_on_one.red.defense = Fabricate(:player)
      expect(one_on_one).to_not be_valid
    end

    it 'absence of player when in a team game' do
      two_on_two.red.player = Fabricate(:player)
      expect(two_on_two).to_not be_valid
    end

    it 'numericality of score' do
      one_on_one.red.score = 'elephant'
      expect(one_on_one).to_not be_valid
    end
  end

  context 'relations' do
    it 'defines belongs_to player' do
      expect(one_on_one.red.reflect_on_association(:player).macro).to eq :belongs_to
    end

    it 'defines belongs_to offense' do
      expect(two_on_two.red.reflect_on_association(:offense).macro).to eq :belongs_to
    end

    it 'defines belongs_to defense' do
      expect(two_on_two.red.reflect_on_association(:defense).macro).to eq :belongs_to
    end

    it 'has a player when in a solo game' do
      expect(one_on_one.red.player).to be_a Player
    end

    it 'does not belong to a player when in a team game' do
      expect(two_on_two.red.player).to_not be
    end

    it 'has an offense when in a team game' do
      expect(two_on_two.red.offense).to be_a Player
    end

    it 'does not belong to an offense when in a solo game' do
      expect(one_on_one.red.offense).to_not be
    end

    it 'has a defense when in a team game' do
      expect(two_on_two.red.defense).to be_a Player
    end

    it 'does not belong to a defense when in a solo game' do
      expect(one_on_one.red.defense).to_not be
    end
  end

  context 'helpers' do
    it 'solo? matches solo status' do
      expect(one_on_one.red.solo?).to be true
      expect(two_on_two.red.solo?).to be false
    end

    it 'team? matches team status' do
      expect(two_on_two.red.team?).to be true
      expect(one_on_one.red.team?).to be false
    end

    it 'unique_players? returns true for solo teams' do
      expect(one_on_one.red.unique_players?).to be true
    end

    it 'unique_players? returns true when players are unique' do
      expect(two_on_two.red.unique_players?).to be true
    end

    it 'unique_players? returns false when players are not unique' do
      two_on_two.red.offense = two_on_two.red.defense = Fabricate(:player)
      expect(two_on_two.red.unique_players?).to be false
    end
  end

  context 'comparability' do
    it 'accurately compares teams' do
      one_on_one.red.score = 10
      one_on_one.blue.score = 5
      one_on_one.save

      expect(one_on_one.red > one_on_one.blue).to be true
      expect(one_on_one.red < one_on_one.blue).to be false
      expect(one_on_one.red == one_on_one.blue).to be false

      one_on_one.red.score = one_on_one.blue.score = 5
      one_on_one.save

      expect(one_on_one.red > one_on_one.blue).to be false
      expect(one_on_one.red < one_on_one.blue).to be false
      expect(one_on_one.red == one_on_one.blue).to be true
    end
  end

end