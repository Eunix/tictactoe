# The Game class of Tic-Tac-Toe. For simplicity and readability I use matrix with
# geometrical series of power of two:
#
# 1   2   4
# 8   16  32
# 64  128 256
#
# If player reaches one of the winning sums the game is over and this player is 
# the winner. Winning sums are very easy to calculate — sum of every three of marks
# in a horizontal, vertical, or diagonal row. For example:  1 + 2 + 4 = 7. A player 
# is the winner if it reaches 7 in total sums of moves
#
# The game starts with player_x's move
class Game < ActiveRecord::Base
  POSITION_MAPPING = [
    1 => 1,  2 => 2,   3 => 4,
    4 => 8,  5 => 16,  6 => 32,
    7 => 64, 8 => 128, 9 => 256
  ]

  WINNING_SUMS = %w(7 56 73 84 146 273 292 448)

  STATES = %w(new finished)

  serialize :player_x_cells, Array
  serialize :player_o_cells, Array

  belongs_to :player_x, class_name: 'Player', foreign_key: 'player_x_id' 
  belongs_to :player_o, class_name: 'Player', foreign_key: 'player_o_id' 

  validates :player_x, :player_o, presence: true

  #before_save :check_winning_sums

  # Returns the total number of moves both of the playes
  def number_of_moves
    (player_x_cells + player_o_cells).size
  end

  # Performs the next move of a player
  def next_move!(position)
    if next_player == player_x
      player_x_cells << position
    else
      player_y_cells << position
    end
    save
  end

  # Returns next player of the move. It is assumed that
  # player_o has the first move
  def next_player
    number_of_moves % 2 == 0 ? player_x : player_o 
  end
end
