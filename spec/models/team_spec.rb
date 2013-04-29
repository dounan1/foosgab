require 'spec_helper'

describe Team do

  context 'validates' do
    let(:one_on_one) { Fabricate(:solo_game) }
    let(:two_on_two) { Fabricate(:team_game) }

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

    it 'numericality of score' do
      one_on_one.red.score = 'elephant'
      expect(one_on_one).to_not be_valid
    end
  end

end