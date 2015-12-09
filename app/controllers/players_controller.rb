class PlayersController < ApplicationController
  # GET /players
  def index
    @players = Player.all.order(score: :desc).limit(7)
    render json: @players   
  end
end
