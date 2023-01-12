require_relative "board.rb"
require_relative "game.rb"
require_relative "user.rb"

user_1 = User.new("player 1")
user_2 = User.new("player 2")
match = Game.new(user_1, user_2).begin_game
