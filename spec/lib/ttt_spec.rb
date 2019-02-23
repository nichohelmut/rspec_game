require 'spec_helper'
require 'ttt'
require 'pry'

describe Position do
  context "#new" do
    it "should inititalize a new board" do
      symbol_x = "1"
      dim = 4
      position = Position.new(dim: dim, symbol_x: symbol_x)
      expect(position.board).to eq(%w(-) * 16)
      expect(position.turn).to eq symbol_x
    end

    it "should initialize a position given a board and turn" do
      position = Position.new(board: %w(- 1 - - - - - - - - - - - - 2 -), dim: 4, turn: "2")
      expect(position.board).to eq(%w(- 1 - - - - - - - - - - - - 2 -))
      expect(position.turn).to eq "2"
    end
  end

  context "#move" do
    it "should make a move" do
      position = Position.new(dim: 3, symbol_x: "1", symbol_o: "2").move(0)
      expect(position.board).to eq(%w(1 - - - - - - - -))
      expect(position.turn).to eq "2"
    end
  end

  context "#unmove" do
    it "should undo a move" do
      position = Position.new(dim: 3).move(1).unmove
      init = Position.new(dim: 3)
      expect(position.board).to eq init.board
      expect(position.turn).to eq init.turn
    end
  end

  context "#possible_moves" do
    it "should list possible moves for initial positions" do
      expect(Position.new(dim: 5).possible_moves).to eq (0..24).to_a
    end
    it " should list possible moves for a position" do
      expect(Position.new(dim: 3).move(5).possible_moves).to eq [0, 1, 2, 3, 4, 6, 7, 8]
    end
  end

  context "#win_lines" do
    it "should find winning columns, rows, diagonals" do
      win_lins = Position.new(board: %w(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15), dim: 4).win_lines
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
      expect(Position.new(dim: 7).win?("1")).to eq false
      expect(Position.new(dim: 3).win?("2")).to eq false
    end
    it "should determine a win for 1" do
      expect(Position.new(board: %w(1 1 1 1 - - - - - - - - 2 - 2 2), dim: 4).win?("1")).to eq true
    end
    it "should determine a win for 2" do
      expect(Position.new(board: %w(1 1 - - - - 2 2 2), dim: 3).win?("2")).to eq true
    end
  end

  context "#tie?" do
    it "should determine not tied" do
      expect(Position.new(dim: 4, symbol_x: "1", symbol_o: "2").tie?).to eq false
    end
    it "should determine not tied" do
      expect(Position.new(board: %w(1 2 1 2 1 2 1 2 1), dim: 3, symbol_x: "1", symbol_o: "2").tie?).to eq false
    end
  end

  context "#evaluate_leaf" do
    it "should determine nothing from initial position" do
      expect(Position.new(dim: 6, symbol_x: "1", symbol_o: "2").evaluate_leaf).to eq nil
    end
    it "should determine a won position for x" do
      expect(Position.new(board: %w(1 - - 2 1 - 2 2 1), dim: 3,  symbol_x: "1", symbol_o: "2").evaluate_leaf).to eq 100
    end
    it "should determine a won position for 2" do
      expect(Position.new(board: %w(1 - - 2 1 - 2 2 2), turn: "2", dim: 3, symbol_x: "1", symbol_o: "2").evaluate_leaf).to eq -100
    end
    it "should determine a tie" do
      expect(Position.new(board: %w(1 2 2 2 1 1 2 1 2), dim: 3, symbol_x: "1", symbol_o: "2").evaluate_leaf).to eq 0
    end
  end

  context "#minmax" do
    it "should determine an already won position" do
      expect(Position.new(board: %w(1 1 - 1 2 2 1 2 2), dim: 3, symbol_x: "1", symbol_o: "2").minimax).to eq 100
    end
    it "should determine a win in 1 for x" do
      expect(Position.new(board: %w(1 1 - - - - - 2 2), turn: "1", dim: 3, symbol_x: "1", symbol_o: "2").minimax).to eq 99
    end
    it "should determine a win in 1 for o" do
      expect(Position.new(board: %w(1 1 - - - - - 2 2), turn: "2", dim: 3, symbol_x: "1", symbol_o: "2").minimax).to eq -99
    end
  end
  context "#best_move" do
    it "should find the winning move for x" do
      expect(Position.new(board: %w(1 1 - - - - - 2 2), turn: "1", dim: 3, symbol_x: "1", symbol_o: "2").best_move).to eq 2
    end
    it "should find the winning move for o" do
      expect(Position.new(board: %w(1 1 - - - - - 2 2), turn: "2", dim: 3, symbol_x: "1", symbol_o: "2").best_move).to eq 6
    end
  end

  context "end?" do
    it "should see a position has not ended" do
      expect(Position.new(dim: 3, symbol_x: "1", symbol_o: "2").end?).to eq false
    end
    it "should see a position has ended due to win for x" do
      expect(Position.new(board: %w(- - 1 - - 1 2 2 1), dim: 3, symbol_x: "1", symbol_o: "2").end?).to eq true
    end
    it "should see a position has ended due to win for o" do
      expect(Position.new(board: %w(- - 1 - - 1 2 2 2), dim: 3, symbol_x: "1", symbol_o: "2").end?).to eq true
    end
    it "should see a position has ended due tie" do
      expect(Position.new(board: %w(1 2 1 1 2 1 2 1 2), dim: 3, symbol_x: "1", symbol_o: "2").end?).to eq true
    end
  end


end