require "./lib/ttt.rb"

class Game
  def ask_for_player
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
      puts "How many fields should each row and size have?"
      puts "choose between 3 and 10"
      print "choice: "
      answer = gets.chomp
      return answer.to_i if (0..10).include? answer.to_i
    end
  end

  def symbol_x
    while true
      puts "Please choose a Symbol you would like to play with."
      puts "Only one letter is allowed"
      puts "choice: "
      answer = gets.chomp
      return answer if answer =~ /[a-z]/
    end
    end

  def symbol_y
    while true
      puts "Please choose a Symbol for the the second player."
      puts "Only one letter is allowed"
      puts "choice: "
      answer = gets.chomp
      return answer if answer =~ /[a-z]/
    end
    end

  def symbol_o
    while true
      puts "Please choose a Symbol for the computer."
      puts "Only one letter is allowed"
      puts "choice: "
      answer = gets.chomp
      return answer if answer =~ /[a-z]/
    end
  end

  def ask_for_move position
    while true
      print "move: "
      answer = gets.chomp
      return answer.to_i if answer =~ /^\d+$/ && position.board[answer.to_i] == "-"
    end
  end

  def other_player
    @player == "human" ? "computer" : "human"
  end

  def play_game
    @player = ask_for_player
    position = Position.new(dim: dim, symbol_x: symbol_x, symbol_o: symbol_o, symbol_y: symbol_y)
    until position.end?
      puts position
      index = @player == "human" || "human2"? ask_for_move(position) : position.best_move
      position.move(index)
      @player = other_player
    end
    puts position
    if position.tie?
      puts "draw"
    else puts "winner: #{other_player}"
    end
  end
end

if __FILE__ == $0
  Game.new.play_game
end
