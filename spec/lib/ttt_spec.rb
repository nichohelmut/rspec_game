require 'spec_helper'
require 'ttt'
require 'pry'

describe Position do

  let(:symbol_x) { "A" }
  let(:symbol_y) { "B" }
  let(:symbol_o) { "C" }
  let(:turn) { "A" }
  let(:dim) { 4 }
  let(:dim_3) { 3 }
  let(:position) { Position.new(dim, symbol_x, symbol_y, symbol_o, turn) }
  let(:position_3) { Position.new(dim_3, symbol_x, symbol_y, symbol_o, turn) }

  context "#new" do
    it "should initialize a new board" do
      expect(position.board).to eq(%w(-) * 16)
      expect(position.turn).to eq symbol_x
    end

    it "should initialize a position given a board and turn" do
      position.board = %w(- A - - - - - - - - - - - B C)
      expect(position.board).to eq(%w(- A - - - - - - - - - - - B C))
      expect(position.turn).to eq symbol_x
    end
  end

  context "#move" do
    it "should make a move" do
      position.move(0)
      expect(position.board).to eq(%w(A - - - - - - - - - - - - - - -))
      expect(position.turn).to eq symbol_y
    end
  end

  context "#other_turn" do
    it "should identify the next player" do
      position.move(1)
      expect(position.other_turn).to eq symbol_o
    end
  end

  context "#possible_moves" do
    it "should list possible moves for initial positions" do
      position = Position.new(5, "a", "b", "c", "c" )
      expect(position.possible_moves).to eq (0..24).to_a
    end

    it " should list possible moves for a position" do
      position.move(15)
      expect(position.possible_moves).to eq [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    end
  end

  context "#win_lines" do
    it "should find winning columns, rows, diagonals" do
      win_lins = Position.new(
          %w(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15), dim, "a", "b", "c", "c"
      ).win_lines
      expect(win_lins).to include ["0", "1", "2", "3"]
      expect(win_lins).to include ["4", "5", "6", "7"]
      expect(win_lins).to include ["8", "9", "10", "11"]
      expect(win_lins).to include ["12", "13", "14", "15"]
      expect(win_lins).to include ["0", "4", "8", "12"]
      expect(win_lins).to include ["1", "5", "9", "13"]
      expect(win_lins).to include ["2", "6", "10", "14"]
      expect(win_lins).to include ["3", "7", "11", "15"]
    end
  end

  context "#win?" do
    it "should determine no win" do
      expect(position.win?(symbol_x)).to eq false
    end
    it "should determine a win for A" do
      position.board = %w(A A A A C A C C B C B - B - B B)
      expect(position.win?(symbol_x)).to eq true
    end
    it "should determine a win for B" do
      expect(Position.new(
          %w(A A C C - - B B B), 3, "a", "b", "c", "b"
      ).win?(symbol_y)).to eq true
    end
  end

  context "#tie?" do
    it "should determine tied" do
      position.board = %w(C C C A
                          B A B A
                          A C B B
                          B B B A)
      expect(position.tie?).to eq true
    end

    it "should determine not tied" do
      position.board = %w(C C C C
                          B A B A
                          A A B B
                          B B B A)
      expect(position.tie?).to eq false
    end
  end

  context "end?" do
    it "should see a position has not ended" do
      expect(position.end?).to eq false
    end
    it "should see a position has ended due to win for A" do
      position_3.board = %w(C C A
                            C - A
                            B B A)
      expect(position_3.end?).to eq true
    end
    it "should see a position has ended due to win for B" do
      position_3.board = %w(C C A
                            C - A
                            B B B)
      expect(position_3.end?).to eq true
    end
    it "should see a position has ended due tie" do
      position_3.board = %w(A B C
                            A C B
                            B A C)
      expect(position_3.end?).to eq true
    end
  end

end
