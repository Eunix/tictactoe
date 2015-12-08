FactoryGirl.define do
  factory :game do
    association :player_x, factory: :player
    association :player_o, factory: :player
  end
end
