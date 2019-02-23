require 'spec_helper'
require 'game'
require 'pry'

describe Game do
  context "#ask_for_player" do
    it "should ask who should play first" do
      game = Game.new
      game.stub(:gets => "1\n")
      game.stub(:puts)
      game.stub(:print)
      expect(game.ask_for_player).to eq "human"
    end
  end

  context "#ask_for_move" do
    it "should ask for a valid move" do
      position = Position.new(dim: 3)
      game = Game.new
      game.stub(:gets => "1\n")
      game.stub(:puts)
      game.stub(:print)
      expect(game.ask_for_move(position)).to eq 1
    end
  end
  # context
end