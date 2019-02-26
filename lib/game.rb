require "./lib/ttt.rb"
require "./lib/player.rb"

class Game

  def player_instance_var
    @human = Player.new(symbol_x, "human", )
    @human2 = Player.new(symbol_y, "human2")
    @computer = Player.new(symbol_o, "computer", )
  end

  def who_plays_first
    player_instance_var
    puts "Who do should start?"
    puts "1. #{@human.type}"
    puts "2. #{@human2.type}"
    puts "3. #{@computer.type}"
    while true
      print "choice: "
      answer = gets.chomp
      return @human if answer == "1"
      return @human2 if answer == "2"
      return @computer if answer == "3"
    end
  end

  def dim
    while true
      puts "How many fields should each row and column have?"
      puts "choose between 3 and 10"
      print "choice: "
      answer = gets.chomp
      return answer.to_i if (3..10).include? answer.to_i
    end
  end

  def symbol_x
    while true
      puts "Please choose one letter for Player 1"
      puts "choice: "
      answer = gets.chomp
      return answer if answer =~ /[A-Za-z]/ && answer.length == 1
    end
  end

  def symbol_y
    while true
      puts "Please choose one letter for Player 2"
      puts "choice: "
      answer = gets.chomp
      return answer if answer =~ /[A-Za-z]/ && answer.length == 1
    end
  end

  def symbol_o
    while true
      puts "Please choose one letter for Computer"
      puts "Only one letter is allowed"
      puts "choice: "
      answer = gets.chomp
      return answer if answer =~ /[A-Za-z]/ && answer.length == 1
    end
  end

  def ask_for_move position
    while true
      print "#{@player.type}'s move: "
      answer = gets.chomp
      return answer.to_i if answer =~ /^\d+$/ && position.board[answer.to_i] == "-"
    end
  end

  def other_player
    if @player.type == "human"
      @human2
    elsif @player.type == "human2"
      @computer
    elsif @player.type == "computer"
      @human
    end
  end

  def player_index(position)
    if @player.type == "human"
      ask_for_move(position)
    elsif @player.type == "human2"
      ask_for_move(position)
    elsif @player.type == "computer"
      position.best_move
    end
  end

  def winner(position)
    return "human" if position.turn == @human2.symbol
    return "human2" if position.turn == @computer.symbol
    "computer" if position.turn == @human.symbol
  end

  def play_game
    @player = who_plays_first
    position = Position.new(dim, @human.symbol, @human2.symbol , @computer.symbol, @player.symbol)
    until position.end?
      table_extend = position.dim > 3 ? ("O" * position.dim) * 2 : ""
      puts "OOOOOOOOOOO#{table_extend}"
      puts position
      index = player_index(position)
      position.move(index)
      @player = other_player
    end
    puts position
    if position.tie?
      puts "draw"
    else
      puts "winner: #{winner(position)}"
    end
  end
end

if __FILE__ == $0
  Game.new.play_game
end
