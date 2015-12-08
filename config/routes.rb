Rails.application.routes.draw do
  resources :games do 
    put :next_move, on: :member
  end

  resources :players, only: [:index]

  root 'games#new'
end
