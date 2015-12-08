class PlayersController < ApplicationController
  def index
    render json: Player.all.order(score: :desc)
  end
end
