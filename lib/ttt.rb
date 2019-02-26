require 'pry'

class Position
  attr_accessor :board, :dim, :symbol_x, :symbol_y, :symbol_o, :turn

  def initialize(
      board=nil, dim, symbol_x, symbol_y, symbol_o, turn
  )
    @dim = dim
    @size = @dim * @dim
    @board = board || Array.new(@size, "-")
    @turn = turn
    @movelist = []
    @symbol_x = symbol_x
    @symbol_y = symbol_y
    @symbol_o = symbol_o
  end

  def other_turn
    if @turn == @symbol_x
      @symbol_y
    elsif @turn == @symbol_y
      @symbol_o
    elsif  @symbol_o
      @symbol_x
    end
  end

  def move index
    @board[index] = @turn
    @turn = other_turn
    @movelist << index
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
    ).map {|line| line.map {|index| @board[index]}
    }
  end

  def win? piece
    win_lines.any? {|line| line.all? {|line_piece| line_piece.include? piece}}
  end

  def tie?
    win_lines.all? do |line|
      (line - Array.new(@dim, @symbol_x)).any? &&
      (line - Array.new(@dim, @symbol_y)).any? &&
      (line - Array.new(@dim, @symbol_o)).any?
    end
  end

  def best_move
    possible_moves.sample
  end

    def end?
    win?(@symbol_x) || win?(@symbol_y) || win?(@symbol_o) || @board.count("-") == 0
  end

  def to_s
    table_extend = @dim > 3 ? ("-" * @dim) * 2 : ""
    @board.each_slice(@dim).map do |line|
      " " + line.map do |piece|
        piece == "-" ? " " : piece end.join(" | ") + " "
    end.join("\n-----------#{table_extend}\n") + "\n"
  end
end
