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

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @@player_turn = @player1
    @game_board = Board.new
  end

  def begin_game
    @game_board.draw_board
    choose_placement
  end

  def choose_placement
    puts "Choose where you would like to place a piece #{@@player_turn.name}!"
    placement = gets.chomp
    @game_board.update_board(placement, @@player_turn.game_piece)
    check_status
  end

  def switch_turns
    @@player_turn == @player1 ? @@player_turn = @player2 : @@player_turn = @player1
  end

  def check_status
    switch_turns
    choose_placement
  end
end
