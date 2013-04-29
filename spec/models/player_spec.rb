require "spec_helper"

describe Player do
  let!(:player) { Player.create({ name: "Paul", type: "GiveGabber" }) }

  context "validates" do
    it "presence of name" do
      player.name = nil
      expect(player).to_not be_valid
    end

    it "presence of type" do
      player.type = nil
      expect(player).to_not be_valid
    end
  end

  context "#games" do
    it "returns empty when player has no games" do
      expect(player.games.entries).to be_empty
    end
  end
end