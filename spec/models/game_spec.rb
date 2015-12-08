require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should belong_to(:player_x) }
  it { should belong_to(:player_o) }
  it { should validate_presence_of(:player_x) }
  it { should validate_presence_of(:player_o) }

  it 'has a valid factory' do
    expect(create(:game)).to be_valid
  end

  describe '.number_of_moves' do
    it 'returns sum of cells both of the players' do
      subject.player_x_cells = [1, 3, 6]
      subject.player_o_cells = [2, 7, 9, 5]
      expect(subject.number_of_moves).to eq(7)
    end
  end

  describe '.next_move' do
    let(:player_x) { create(:player) }
    let(:player_o) { create(:player) }

    before do
      subject.player_x = player_x
      subject.player_o = player_o
    end

    it 'adds next position to player_o' do
      subject.player_x_cells = [1, 2]
      subject.player_o_cells = [3]
      subject.next_move!(4)
      expect(subject.player_o_cells).to eq([3, 4])
    end
  end

  describe '.next_player' do
    let(:player_x) { create(:player) }
    let(:player_o) { create(:player) }

    before do
      subject.player_x = player_x
      subject.player_o = player_o
    end

    it 'returns player_o if the number of moves is odd' do
      allow(subject).to receive(:number_of_moves).and_return(3)
      expect(subject.next_player).to eq(player_o)
    end

    it 'returns player_x if the number of moves is even' do
      allow(subject).to receive(:number_of_moves).and_return(4)
      expect(subject.next_player).to eq(player_x)
    end
  end
end
