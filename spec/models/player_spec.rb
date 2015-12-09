require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should have_many(:games_as_player_x) }
  it { should have_many(:games_as_player_o) }
  it { should validate_uniqueness_of(:name) }

  it 'has a valid factory' do
    expect(create(:player)).to be_valid
  end

  describe '.games' do
    let(:player1) { create(:player) }
    let(:player2) { create(:player) }
    let!(:game1) { create(:game, player_o: player1) }
    let!(:game2) { create(:game, player_x: player1) }
    let!(:game3) { create(:game, player_o: player1) }
    let!(:game4) { create(:game, player_x: player2) }
  
    it 'returns total number of games' do
      expect(player1.games.size).to eq(3)
    end
  end

  describe '.update_score' do
    let(:player) { create(:player) }
    
    before { create_list(:game, 2, winner: player) }

    it 'updates score as number of wins' do
      player.reload
      expect{ player.touch }.to change{ player.score }.from(0).to(2)
    end
  end
end
