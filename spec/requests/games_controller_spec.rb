require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'POST create' do
    it 'creates new game' do
      post :create, game: { player_x_name: 'Player1', player_o_name: 'Player2' }
      game = Game.last
      expect(response.status).to eq(200)
      expect(assigns(:game)).to eq(game)
      expect(game.player_x.name).to eq('Player1')
      expect(game.player_o.name).to eq('Player2')
    end
  end

  describe 'PUT next_move' do
    let!(:game) { create(:game) }

    it 'performs next move of game' do
      put :next_move, id: game.id, position: 1
      expect(response.status).to eq(200)
      expect(game.reload.player_x_cells).to eq([1])
    end
  end
end
