require "spec_helper"

describe Player do
  context "validates" do
    it "presence of name" do
      expect(Fabricate.build(:player, name: nil)).to_not be_valid
    end

    it "presence of type" do
      expect(Fabricate.build(:player, type: nil)).to_not be_valid
    end
  end

  context "#games" do
    it "returns empty when player has no games" do
      expect(Fabricate(:player).games.entries).to be_empty
    end

    it "returns a list of games when player has games" do
      player = Fabricate(:player)
      game = Fabricate(:solo_game, red: Fabricate.build(:solo, player: player))

      expect(player.games.entries).to_not be_empty
    end
  end

  context "stats helpers" do
    context "#average_score" do
      it "returns the average score" do
        player = Fabricate(:player)
        Fabricate(:solo_game, red: Fabricate.build(:solo, player: player, score: 6))
        Fabricate(:solo_game, red: Fabricate.build(:solo, player: player, score: 4))
        expect(player.average_score).to eq 5
      end

      it "returns 0 when player has no games" do
        expect(Fabricate(:player).average_score).to eq 0
      end
    end

    context "#win_pct" do
      it "returns the winning percentage" do
        player = Fabricate(:player)

        Fabricate(:solo_game, red: Fabricate.build(:solo, score: 10, player: player),
          blue: Fabricate.build(:solo, score: 1))

        expect(player.win_pct).to eq 1

        3.times { Fabricate(:solo_game, red: Fabricate.build(:solo, score: 1, player: player),
                                blue: Fabricate.build(:solo, score: 10)) }

        expect(player.win_pct).to eq 0.25
      end

      it "returns 0 when player has no games" do
        expect(Fabricate(:player).average_score).to eq 0
      end
    end
  end
end