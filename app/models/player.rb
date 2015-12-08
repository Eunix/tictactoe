class Player < ActiveRecord::Base
  has_many :games_as_player_x, class_name: 'Game', foreign_key: 'player_x_id' 
  has_many :games_as_player_o, class_name: 'Game', foreign_key: 'player_o_id' 
  has_many :games_as_winner, class_name: 'Game', foreign_key: 'winner_id' 

  after_touch :update_score

  validates :name, uniqueness: true, presence: true

  def games
    games_as_player_o + games_as_player_x
  end

  private

  def update_score
    update_column('score', games_as_winner.size)
  end
end
