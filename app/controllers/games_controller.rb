class GamesController < ApplicationController
  def create
    @game = Game.new(game_params)
    if @game.save
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  def next_move
    @game = Game.find(params[:id])
    if @game.next_move!(params[:position])
      render json: { symbol: @game.last_symbol }
    end
  end

  private

  def game_params
    params.require(:game).permit(:player_x_name, :player_o_name)
  end
end
