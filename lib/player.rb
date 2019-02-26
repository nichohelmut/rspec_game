require "./lib/game.rb"

class Player
  attr_reader :symbol, :type

  def initialize(symbol = nil, type)
    @type = type
    @symbol = symbol
  end
end
