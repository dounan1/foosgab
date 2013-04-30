require 'spec_helper'

describe Player do
  let(:player1) { Fabricate(:player) }

  it 'has a valid factory' do
    expect(player1).to be_valid
  end

  context 'validates' do
    it 'presence of name' do
      expect(Fabricate.build(:player, name: nil)).to_not be_valid
    end

    it 'presence of type' do
      expect(Fabricate.build(:player, type: nil)).to_not be_valid
    end
  end

  context 'games helpers' do
    context '#games' do
      it 'returns empty when player has no games' do
        expect(player1.games.entries).to be_empty
      end

      it 'returns a list of games when player has games' do
        Fabricate(:solo_game, red: Fabricate.build(:solo, player: player1))
        expect(player1.games.entries).to_not be_empty
      end
    end

    context 'for games won' do
      before(:each) do
        3.times { Fabricate(:solo_game, red: Fabricate.build(:solo, player: player1, score: 10),
          blue: Fabricate.build(:solo, score: 0)) }
      end

      it 'returns the complete list of games won' do
        expect(player1.games_won.entries).to have(3).items
      end

      it 'returns the number of games won' do
        expect(player1.wins).to eq 3
      end
    end

    context 'for games lost' do
      before(:each) do
        3.times { Fabricate(:solo_game, red: Fabricate.build(:solo, player: player1, score: 0),
          blue: Fabricate.build(:solo, score: 10)) }
      end

      it 'returns the complete list of games lost' do
        expect(player1.games_lost.entries).to have(3).items
      end

      it 'returns the number of games lost' do
        expect(player1.losses).to eq 3
      end
    end

    context 'for games tied' do
      before(:each) do
        3.times { Fabricate(:solo_game, red: Fabricate.build(:solo, player: player1, score: 5),
          blue: Fabricate.build(:solo, score: 5)) }
      end

      it 'returns the complete list of games tied' do
        expect(player1.games_tied.entries).to have(3).items
      end

      it 'returns the number of games tied' do
        expect(player1.ties).to eq 3
      end
    end
  end

  context 'stats helpers' do
    context '#average_score' do
      it 'returns the average score' do
        Fabricate(:solo_game, red: Fabricate.build(:solo, player: player1, score: 6))
        Fabricate(:solo_game, red: Fabricate.build(:solo, player: player1, score: 4))
        expect(player1.average_score).to eq 5
      end

      it 'returns 0 when player has no games' do
        expect(player1.average_score).to eq 0
      end
    end

    context '#win_pct' do
      it 'returns the winning percentage' do
        Fabricate(:solo_game, red: Fabricate.build(:solo, score: 10, player: player1),
          blue: Fabricate.build(:solo, score: 1))

        expect(player1.win_pct).to eq 1

        3.times { Fabricate(:solo_game, red: Fabricate.build(:solo, score: 1, player: player1),
                                blue: Fabricate.build(:solo, score: 10)) }

        expect(player1.win_pct).to eq 0.25
      end

      it 'returns 0 when player has no games' do
        expect(player1.average_score).to eq 0
      end
    end
  end
end