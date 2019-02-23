#!/usr/bin/env ruby
require 'pry'
class Position
  attr_accessor :board, :turn, :dim, :symbol_x, :symbol_o

  def initialize(board: board=nil, dim:  dim, symbol_o: symbol_o, symbol_x: symbol_x, turn: turn=symbol_x)
    @dim = dim
    @size = @dim * @dim
    @board = Array.new(@size, "-")
    @turn = turn
    @movelist = []
    @symbol_x = symbol_x
    @symbol_o = symbol_o
  end

  def other_turn
    @turn == @symbol_x ? @symbol_o : @symbol_x
  end

  def move index
    @board[index] = @turn
    @turn = other_turn
    @movelist << index
  end

  def unmove
    @board[@movelist.pop] = "-"
    @turn = other_turn
    self
  end

  def possible_moves
    @board.map.with_index { |piece, index| piece == "-" ? index : nil }.compact
  end

  def win_lines
    (
      (0..@size - 1).each_slice(@dim).to_a +
      (0..@size - 1).each_slice(@dim).to_a.transpose +
      [(0..@size - 1).step(@dim.next).to_a] +
      [ (@dim - 1..(@size-@dim)).step(@dim - 1).to_a ]
    ).map do |line|
      line.map do |index|
         @board[index]

      end
    end
  end

  def win? piece
    win_lines.any? do |line|
      line.all? do |line_piece|
        line_piece.include? piece
      end
    end
  end

  def tie?
    win_lines.all? do |line|
      line.any? { |line_piece| line_piece.include? @symbol_x} &&
      line.any? { |line_piece| line_piece.include? @symbol_o}
    end
  end

  def evaluate_leaf
    return 100 if win?(@symbol_x)
    return -100 if win?(@symbol_o)
    0 if tie?
  end

  def minimax(index = nil)
    move(index) if index
    leaf_value = evaluate_leaf
    return leaf_value if leaf_value
    possible_moves.map do |index|
      # minimax(index).send(@turn == @symbol_x || @symbol_y ? :- : :+, @movelist.count + 1)
      index
    end.send(@turn == @symbol_x ? :max : :min)
    ensure unmove if index
  end

  def best_move
    possible_moves.send(@turn == @symbol_x || @symbol_y ? :max_by : :min_by) {|idx| minimax(idx)}
  end

    def end?
    win?(@symbol_x) || win?(@symbol_o) || @board.count("-") == 0
  end

  def to_s
    table_extend = @dim > 3 ? ("-" * @dim) * 2 : ""
    @board.each_slice(@dim).map do |line|
      " " + line.map do |piece|
        piece == "-" ? " " : piece end.join(" | ") + " "
    end.join("\n-----------#{table_extend}\n") + "\n"
  end
end
