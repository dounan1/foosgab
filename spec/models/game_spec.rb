require 'spec_helper'

describe Game do
  let(:game) { Fabricate(:game) }
  let(:solo_game) { Fabricate(:solo_game) }

  it 'has a valid factory for team games' do
    expect(game).to be_valid
  end

  it 'has a valid factory for solo games' do
    expect(solo_game).to be_valid
  end

  context 'validates' do
    it 'presence of date' do
      game.date = nil
      expect(game).to_not be_valid
    end

    it 'uniqueness of each player' do
      game.red.offense = game.red.defense = Fabricate(:player)
      expect(game).to_not be_valid
    end
  end

  context 'helpers' do
    it '#players returns all its players' do
      players = [game.red.offense, game.red.defense, game.blue.offense, game.blue.defense]
      expect(game.players).to match_array players
      player = game.blue.defense = Fabricate(:player)
      players.reverse.pop(3).push player
      expect(game.players).to match_array players
    end

    it '#unique_players? returns true when players are unique' do
      expect(game.unique_players?).to be_true
    end

    it '#unique_players? returns false when players are not unique' do
      game.red.offense = game.blue.defense = Fabricate(:player)
      expect(game.unique_players?).to be_false
    end

    it '#solo? returns true if a solo game' do
      expect(solo_game.solo?).to be_true
    end

    it '#solo? returns false if a team game' do
      expect(game.solo?).to be_false
    end    

    it '#team_with_player returns the team with the given player' do
      player = game.blue.offense = Fabricate(:player)
      # object identity doesn't seem to work, even though the object inspects seem identical
      # so falling back to bson object ids
      expect(game.team_with_player(player)._id).to eq game.blue._id
    end
  end

  context 'state' do
    it '#winner returns its winning team' do
      (game.red.score, game.blue.score = 5, 10) and game.save
      expect(game.winner._id).to eq game.blue._id
      (game.red.score, game.blue.score = 10, 5) and game.save
      expect(game.winner._id).to eq game.red._id
    end

    it '#loser returns its losing team' do
      (game.red.score, game.blue.score = 5, 10) and game.save
      expect(game.loser._id).to eq game.red._id
      (game.red.score, game.blue.score = 10, 5) and game.save
      expect(game.loser._id).to eq game.blue._id
    end
    
    it '#tie? returns true if tied and false otherwise' do
      game.red.score = game.blue.score = 5 and game.save
      expect(game.tie?).to be_true
      game.red.score += 1 and game.save
      expect(game.tie?).to be_false
    end
  end
  # presence of embedded? (red/blue)
end