require 'spec_helper'
require 'game'
require 'pry'

describe Game do

  let(:game) { Game.new }
  let(:position) { Position.new(3, "a", "b", "c", "a") }
  let(:human) { Player.new("a", "human") }

  context "#player_instance_var" do
    it "should return symbol_o and type from @human" do
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

  context "#symbols_x" do
    it "should ask for symbol for player 1" do
      game.stub(gets: "A")
      expect(game.symbol_x).to eq "A"
    end
  end

  context "#answer_validation"
    it "should validate the user input to be one letter" do
      expect(game.answer_validation("B")).to eq true
      expect(game.answer_validation("b")).to eq true
      expect(game.answer_validation("1")).to eq nil
      expect(game.answer_validation("%")).to eq nil
    end
end
