require "./lib/ttt.rb"
require "./lib/player.rb"

class Game
  def who_plays_first
    puts "Who do should start?"
    puts "1. human"
    puts "2. human2"
    puts "3. computer"
    while true
      print "choice: "
      answer = gets.chomp
      return "human" if answer == "1"
      return "human2" if answer == "2"
      return "computer" if answer == "3"
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
      print "#{player_turn}'s move: "
      answer = gets.chomp
      return answer.to_i if answer =~ /^\d+$/ && position.board[answer.to_i] == "-"
    end
  end

  def other_player
    if @player == "human"
      "human2"
    elsif @player == "human2"
      "computer"
    elsif @player == "computer"
      "human"
    end
  end

  def player_index(position)
    if @player == "human"
      ask_for_move(position)
    elsif @player == "human2"
      ask_for_move(position)
    elsif @player == "computer"
      position.best_move
    end
  end

  def player_turn
    if @player == "human"
      @human.symbol
    elsif @player == "human2"
      @human2.symbol
    elsif @player == "computer"
      @computer.symbol
    end
  end

  def player_instance_var
    @human = Player.new(symbol_x, "human", )
    @human2 = Player.new(symbol_y, "human2")
    @computer = Player.new(symbol_o, "computer", )
  end

  def play_game
    @player = who_plays_first
    player_instance_var
    position = Position.new(dim, @human.symbol, @human2.symbol , @computer.symbol, player_turn)
    until position.end?
      puts position
      index = player_index(position)
      position.move(index)
      @player = other_player
    end
    puts position
    if position.tie?
      puts "draw"
    else
      puts "winner: #{other_player}"
    end
  end
end

if __FILE__ == $0
  Game.new.play_game
end
