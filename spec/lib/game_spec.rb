require 'spec_helper'
require 'game'
require 'pry'

describe Game do

  let(:game) {Game.new}
  let(:position) {Position.new(3, "a", "b", "c", "a")}

  context "#who_plays_first" do
    it "should ask who should play first" do
      game.stub(gets: "1\n")
      expect(game.who_plays_first).to eq "human"
    end
  end

  context "#ask_for_move" do
    it "should ask for a valid move" do
      game.stub(gets: "1\n")
      expect(game.ask_for_move(position)).to eq 1
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

  context "#player_instance_var" do
    it "@computer with symbol_o and 'computer' type" do
      human = Player.new("c", "computer")
      expect(human.symbol).to eq "c"
      expect(human.type).to eq "computer"
    end
  end
end
