class Player < ActiveRecord::Base
  has_many :games_as_player_x, class_name: 'Game', foreign_key: 'player_x_id' 
  has_many :games_as_player_o, class_name: 'Game', foreign_key: 'player_o_id' 

  validates :name, uniqueness: true

  def games
    games_as_player_o + games_as_player_x
  end
end
