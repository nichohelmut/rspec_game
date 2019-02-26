require 'spec_helper'
require 'game'
require 'pry'

describe Game do

  let(:game) { Game.new }
  let(:position) { Position.new(3, "a", "b", "c", "a") }
  let(:human) { Player.new("a", "human") }

  context "#player_instance_var" do
    it "@computer with symbol_o and 'human' type" do
      expect(human.symbol).to eq "a"
      expect(human.type).to eq "human"
    end
  end

  context "#dim" do
    it "should ask for size of board" do
      game.stub(gets: "3\n")
      expect(game.dim).to eq 3
    end
  end

  context "symbols methos" do
    it "#symbol_x should ask for symbol for player 1" do
      game.stub(gets: "A")
      expect(game.symbol_x).to eq "A"
    end

    it "#symbol_y should ask for symbol for player 2" do
      game.stub(gets: "B")
      expect(game.symbol_y).to eq "B"
    end

    it "#symbol_o should ask for symbol for computer" do
      game.stub(gets: "C")
      expect(game.symbol_o).to eq "C"
    end
  end

end
