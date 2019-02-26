require 'spec_helper'
require 'player'
require 'pry'

describe Player do

  context "#initialize" do
    it "should initialize a new player" do
      player = Player.new("a", "human")
      expect(player.symbol).to eq "a"
      expect(player.type).to eq "human"
    end
  end
end
