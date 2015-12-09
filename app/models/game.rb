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
  POSITION_MAPPING = {
    1 => 1,  2 => 2,   3 => 4,
    4 => 8,  5 => 16,  6 => 32,
    7 => 64, 8 => 128, 9 => 256
  }

  WINNING_SUMS = [7, 56, 73, 84, 146, 273, 292, 448]

  STATES = %w(new finished)

  serialize :player_x_cells, Array
  serialize :player_o_cells, Array

  belongs_to :player_x, class_name: 'Player', foreign_key: 'player_x_id' 
  belongs_to :player_o, class_name: 'Player', foreign_key: 'player_o_id' 
  belongs_to :winner, class_name: 'Player', foreign_key: 'winner_id' 

  validates :player_x, :player_o, presence: true

  before_save :check_winning_sums

  delegate :name, to: :winner, prefix: true, allow_nil: true

  def player_x_name=(name)
    self.player_x = Player.find_or_create_by(name: name)
  end

  def player_o_name=(name)
    self.player_o = Player.find_or_create_by(name: name)
  end

  # Returns the total number of moves both of the playes
  def number_of_moves
    player_x_cells.size + player_o_cells.size
  end

  # Performs the next move of a player
  def next_move!(position)
    return if state == 'finished'
    if next_player == player_x
      player_x_cells << position.to_i
    else
      player_o_cells << position.to_i
    end
    save
  end

  # Returns last player's symbol
  def last_symbol
    number_of_moves % 2 == 0 ? 'o' : 'x' 
  end

  # Returns next player of the move. It is assumed that
  # player_o has the first move
  def next_player
    number_of_moves % 2 == 0 ? player_x : player_o 
  end

  # Winner is checked using Bitwise-AND (whether player's sum 
  # contains some of the winning sum)
  def check_winning_sums
    if WINNING_SUMS.any? { |s| s & player_x_sum == s }
      self.winner = player_x
    elsif WINNING_SUMS.any? { |s| s & player_o_sum == s }
      self.winner = player_o
    end
    winner.touch if winner
    self.state = 'finished' if winner || number_of_moves > 8
  end

  # Retuns sum of player_x's positions
  def player_x_sum
    player_x_cells.inject(0) { |sum, c| sum + POSITION_MAPPING[c] }
  end

  # Retuns sum of player_o's positions
  def player_o_sum
    player_o_cells.inject(0) { |sum, c| sum + POSITION_MAPPING[c] }
  end
end
