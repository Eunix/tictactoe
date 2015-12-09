require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should belong_to(:player_x) }
  it { should belong_to(:player_o) }
  it { should validate_presence_of(:player_x) }
  it { should validate_presence_of(:player_o) }

  it 'has a valid factory' do
    expect(create(:game)).to be_valid
  end

  describe '.player_x_name=' do
    it 'creates new player_x' do
      subject.player_x_name = 'My new player x'
      expect(subject.player_x.name).to eq('My new player x')
    end

    it 'uses existed player_x' do
      player_x = create(:player, name: 'Existed player x')
      subject.player_x_name = 'Existed player x'
      expect(subject.player_x.id).to eq(player_x.id)
    end
  end

  describe '.player_o_name=' do
    it 'creates new player_o' do
      subject.player_o_name = 'My new player o'
      expect(subject.player_o.name).to eq('My new player o')
    end

    it 'uses existed player_o' do
      player_o = create(:player, name: 'Existed player o')
      subject.player_o_name = 'Existed player o'
      expect(subject.player_o.id).to eq(player_o.id)
    end
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

  describe '.last_symbol' do
    it 'returns x if the number of moves is odd' do
      allow(subject).to receive(:number_of_moves).and_return(3)
      expect(subject.last_symbol).to eq('x')
    end

    it 'returns o if the number of moves is even' do
      allow(subject).to receive(:number_of_moves).and_return(4)
      expect(subject.last_symbol).to eq('o')
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

  describe '.check_winning_sums' do
    let(:player_x) { create(:player) }
    let(:player_o) { create(:player) }

    before do 
      subject.player_x = player_x
      subject.player_o = player_o
    end

    it 'changes state if number of moves more than 8' do
      allow(subject).to receive(:number_of_moves).and_return(9)
      expect{ subject.check_winning_sums }.to change{ subject.state }.from('new').to('finished')
    end

    it 'changes state and defines winner if player x has winning sum' do
      allow(subject).to receive(:player_x_sum).and_return(7)
      expect{ subject.check_winning_sums }.to change{ subject.state }.from('new').to('finished')
      expect(subject.winner).to eq(player_x)
    end

    it 'defines winner for player o with sum not from winning sums' do
      allow(subject).to receive(:player_o_sum).and_return(178)
      expect{ subject.check_winning_sums }.to change{ subject.state }.from('new').to('finished')
      expect(subject.winner).to eq(player_o)
    end
  end

  describe '.player_x_sum' do
    it 'returns sum of positions using mappings' do
      subject.player_x_cells = [1, 2, 3]
      expect(subject.player_x_sum).to eq(7)
    end
  end

  describe '.player_o_sum' do
    it 'returns sum of positions using mappings' do
      subject.player_o_cells = [3, 4, 5]
      expect(subject.player_o_sum).to eq(28)
    end
  end
end
