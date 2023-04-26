require_relative "board.rb"

class User
  attr_accessor :player, :name, :game_piece

  def initialize(player, name = player_name(player), game_piece = player_game_piece(player))
    @player = player
    @name = name
    @game_piece = game_piece
  end

  def player_name(player)
    puts "Hello #{player}, please enter your name." 
    gets.chomp
  end

  def player_game_piece(player)
    if player == "player 1"
      puts "Okay #{@name}, you will use X's and go first."
      'X'
    else
      puts "#{@name}, you will move second using O's."
      'O'
    end
  end
end
