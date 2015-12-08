Rails.application.routes.draw do
  resources :games do 
    put :next_move, on: :member
  end

  root 'games#new'
end
