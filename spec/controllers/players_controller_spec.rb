require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  describe 'GET index' do
    it 'assigns @players' do
      player = create(:player)
      get :index
      expect(assigns(:players)).to eq([player])
    end

    it 'orders by score' do
      player1 = create(:player, score: 10)
      player2 = create(:player, score: 3)
      player3 = create(:player, score: 56)
      get :index
      expect(assigns(:players)).to eq([player3, player1, player2])
    end
  end
end
