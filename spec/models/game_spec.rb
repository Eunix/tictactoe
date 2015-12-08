require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should belong_to(:player_x) }
  it { should belong_to(:player_o) }
  it { should validate_presence_of(:player_x) }
  it { should validate_presence_of(:player_o) }

  it 'has a valid factory' do
    expect(create(:game)).to be_valid
  end
end
