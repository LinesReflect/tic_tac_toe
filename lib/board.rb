require_relative "game.rb"

class Board
  attr_accessor :spots

  def initialize(spots = ["1", "2", "3", "4", "5", "6", "7", "8", "9"])
    @spots = spots
  end

  def draw_board()
    puts row_one = @spots[0..2].join(" | ")
    puts row = "--+---+--"
    puts row_two = @spots[3..5].join(" | ")
    puts row
    puts row_three = @spots[6..8].join(" | ")
  end

  def update_board(num, player)
    num = num.to_i
    num -= 1
    @spots[num] = player
    draw_board
  end
end
