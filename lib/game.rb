require_relative "board.rb"

class Game
  @@winning_combos = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 4, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]
  attr_accessor :game_board

  def initialize(player1, player2, game_board: Board)
    @player1 = player1
    @player2 = player2
    @player_turn = @player1
    @game_board = game_board.new
  end

  def begin_game
    draw_board
    play_game
  end

  def play_game
    puts "Choose where you would like to place a piece #{@player_turn.name}!"
    choose_placement
    check_status
  end

  def draw_board
    @game_board.draw_board
  end

  def choose_placement
    loop do
      spot = gets
      spot = '' if spot.nil?
      # spot.chomp
      if !spot_taken?(spot)
        @game_board.update_board(spot, @player_turn.game_piece)
        break
      end
      
      puts "That spot is taken, choose again!"
    end
  end

  def player_placement
    puts "Choose where you would like to place a piece #{@@player_turn.name}!"
    gets.chomp
  end


  def switch_turns
    @player_turn == @player1 ? @player_turn = @player2 : @player_turn = @player1
  end

  def check_status
    if player_won?
      puts "#{@player_turn.name} is the winner!"
    elsif player_draw?
      puts "It's a draw!"
    else
      switch_turns
      play_game
    end
  end

  def spot_taken?(num)
    num = num.to_i
    num -= 1
    return true if ["X", "O"].include?(@game_board.spots[num])

    false
  end

  def player_won?
    @@winning_combos.each do |combo|
      placement_index_1 = combo[0]
      placement_index_2 = combo[1]
      placement_index_3 = combo[2]

      spot_1 = @game_board.spots[placement_index_1]
      spot_2 = @game_board.spots[placement_index_2]
      spot_3 = @game_board.spots[placement_index_3]

      return true if spot_1 == spot_2 && spot_2 == spot_3
    end
    false
  end

  def player_draw?
    @game_board.spots.all? {|spot| spot == "X" || spot == "O"}
  end
end
