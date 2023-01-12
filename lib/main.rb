require_relative "board.rb"
require_relative "game.rb"
require_relative "user.rb"

def create_game
  user_1 = User.new("player 1")
  user_2 = User.new("player 2")
  Game.new(user_1, user_2).begin_game
  another_game
end

def another_game
  puts "Would you like to play again? Y/N"
  answer = gets.chomp
  if answer == "Y" || answer == "N"
    puts answer == "Y" ? create_game : "Thanks for playing!"
  else
    puts "Please answer with 'Y' or 'N'"
    another_game
  end
end

create_game
