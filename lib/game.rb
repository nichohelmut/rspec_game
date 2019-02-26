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
    puts "Who should start?"
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

  def answer_validation(answer)
    answer =~ /[A-Za-z]/ && answer.length == 1
  end

  def symbol_x
    while true
      puts "Please choose one letter for Player 1"
      puts "choice: "
      answer = gets.chomp
      return answer if answer_validation(answer)
    end
  end

  def symbol_y
    while true
      puts "Please choose one letter for Player 2"
      puts "choice: "
      answer = gets.chomp
      return answer if answer_validation(answer) && answer != @human.symbol
    end
  end

  def symbol_o
    while true
      puts "Please choose one letter for Computer"
      puts "Only one letter is allowed"
      puts "choice: "
      answer = gets.chomp
      return answer if answer_validation(answer) && answer != @human.symbol && answer != @human2.symbol
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
   return @human2 if @player.type == "human"
   return @computer if @player.type == "human2"
   @human
  end

  def player_index(position)
    return ask_for_move(position) if @player.type == "human"
    return ask_for_move(position) if @player.type == "human2"
    position.best_move
  end

  def winner(position)
    return "human" if position.turn == @human2.symbol
    return "human2" if position.turn == @computer.symbol
    "computer" if position.turn == @human.symbol
  end

  def table_extend(position)
    table_extend = position.dim > 3 ? ("O" * position.dim) * 2 : ""
    large_table = position.dim > 7 ? ("O" * position.dim) : ""
    puts "OOOOOOOOOOO#{table_extend}#{large_table}"
  end

  def play_game
    @player = who_plays_first
    position = Position.new(dim, @human.symbol, @human2.symbol , @computer.symbol, @player.symbol)
    until position.end?
      table_extend(position)
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
