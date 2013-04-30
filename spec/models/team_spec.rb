require 'spec_helper'

describe Team do
  let(:one_on_one) { Fabricate.build(:solo_game) }
  let(:two_on_two) { Fabricate.build(:team_game) }

  it 'has a valid factory in solo games' do
    expect(one_on_one.red).to be_valid
  end

  it 'has a valid factory in team games' do
    expect(one_on_one.red).to be_valid
  end

  describe 'validations' do
    describe 'score' do
      it 'validates presence' do
        one_on_one.red.score = 'nil'
        expect(one_on_one.red).to_not be_valid
      end

      it 'validates numericality' do
        one_on_one.red.score = 'elephant'
        expect(one_on_one.red).to_not be_valid
      end

      it 'validates integrality' do
        one_on_one.red.score = 5.5
        expect(one_on_one.red).to_not be_valid
      end

      it 'validates range between 0 and 10 inclusive' do
        one_on_one.red.score = -1
        expect(one_on_one.red).to_not be_valid
        one_on_one.blue.score = 11
        expect(one_on_one.blue).to_not be_valid
      end
    end

    context 'in a team game' do
      it 'validates presence of offense when in a team game' do
        two_on_two.red.offense = nil
        expect(two_on_two.red).to_not be_valid
      end

      it 'validates presence of defense when in a team game' do
        two_on_two.red.defense = nil
        expect(two_on_two.red).to_not be_valid
      end

      it 'validates absence of player when in a team game' do
        two_on_two.red.player = Fabricate(:player)
        expect(two_on_two.red).to_not be_valid
      end
    end

    context 'in a solo game' do
      it 'validates presence of player when in a solo game' do
        one_on_one.red.player = nil
        expect(one_on_one.red).to_not be_valid
      end

      it 'validates absence of offense when in a solo game' do
        one_on_one.red.offense = Fabricate(:player)
        expect(one_on_one.red).to_not be_valid
      end

      it 'validates absence of defense when in a solo game' do
        one_on_one.red.defense = Fabricate(:player)
        expect(one_on_one.red).to_not be_valid
      end
    end
  end

  describe 'relations' do
    it 'defines belongs_to player' do
      expect(one_on_one.red.reflect_on_association(:player).macro).to eq :belongs_to
    end

    it 'defines belongs_to offense' do
      expect(two_on_two.red.reflect_on_association(:offense).macro).to eq :belongs_to
    end

    it 'defines belongs_to defense' do
      expect(two_on_two.red.reflect_on_association(:defense).macro).to eq :belongs_to
    end

    context 'in a solo game' do
      it 'has a player' do
        expect(one_on_one.red.player).to be_a Player
      end

      it 'does not have an offense' do
        expect(one_on_one.red.offense).to_not be
      end

      it 'does not have a defense' do
        expect(one_on_one.red.defense).to_not be
      end
    end

    context 'in a team game' do
      it 'does not belong to a player' do
        expect(two_on_two.red.player).to_not be
      end

      it 'has an offense' do
        expect(two_on_two.red.offense).to be_a Player
      end

      it 'has a defense' do
        expect(two_on_two.red.defense).to be_a Player
      end
    end
  end

  describe 'helpers' do
    context 'in a solo game' do
      it '#solo? returns true' do
        expect(one_on_one.red.solo?).to be_true
      end
      
      it '#team? returns false' do
        expect(one_on_one.red.team?).to be_false
      end

      it '#unique_players? returns true' do
        expect(one_on_one.red.unique_players?).to be_true
      end
    end

    context 'in a team game' do
      it '#solo? returns false' do
        expect(two_on_two.red.solo?).to be_false
      end
      
      it '#team? returns true' do
        expect(two_on_two.red.team?).to be_true
      end

      it '#unique_players? returns true when players are unique' do
        expect(two_on_two.red.unique_players?).to be_true
      end

      it '#unique_players? returns false when players are not unique' do
        two_on_two.red.offense = two_on_two.red.defense = Fabricate(:player)
        expect(two_on_two.red.unique_players?).to be_false
      end
    end
  end

  describe 'comparability' do
    it 'accurately compares teams' do
      (one_on_one.red.score, one_on_one.blue.score = 10, 5) and one_on_one.save
      
      expect(one_on_one.red > one_on_one.blue).to be_true
      expect(one_on_one.red < one_on_one.blue).to be_false
      expect(one_on_one.red == one_on_one.blue).to be_false

      (one_on_one.red.score = one_on_one.blue.score = 5) and one_on_one.save

      expect(one_on_one.red > one_on_one.blue).to be_false
      expect(one_on_one.red < one_on_one.blue).to be_false
      expect(one_on_one.red == one_on_one.blue).to be_true
    end
  end

end