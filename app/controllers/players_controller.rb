class PlayersController < ApplicationController
  def index
    render json: Player.all.order(score: :desc).limit(7)
  end
end
