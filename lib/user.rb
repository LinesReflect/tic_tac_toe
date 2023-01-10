require_relative "board.rb"

class User
  attr_accessor :player, :name, :game_piece

  def initialize(player, name = set_name(player), game_piece = set_game_piece(player))
    @player = player
    @name = name
    @game_piece = game_piece 
  end

  def set_name(player)
    puts "Hello #{player}, please enter your name." 
    return self.name = gets.chomp
  end

  def set_game_piece(player)
    if player == "player 1"
      puts "Okay #{@name}, you will use X's and go first."
      return "X"
    else
      puts "#{@name}, you will move second using O's."
      return "O"
    end
  end
end