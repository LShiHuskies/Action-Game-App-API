Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :user_games, only: [:index, :new, :show, :create, :destroy]
    resources :games
    resources :chatrooms
    resources :messages
    resources :account_activations, only: [:edit]
    resources :password_resets, only: [:new, :create, :edit, :update]
  end
  get 'login', to: 'api/sessions#new'
  post 'login', to: 'api/sessions#create'
  post 'recover', to: 'api/sessions#recover'
  delete 'logout', to: 'api/sessions#destroy'
  get 'main_room', to: 'api/games#main_room'
  get 'main_room_chatroom', to: 'api/games#main_room_chatroom'
  get 'top_scores', to: 'api/games#top_scores'
  get 'versus_lobby', to: 'api/games#versus_mode_lobby'
  get 'versus_mode_main_chatroom', to: 'api/games#versus_mode_main_chatroom'
  get 'available_versus_games', to: 'api/games#available_versus_games'
  get 'search_game', to: 'api/users#search_game'
  patch 'play', to: 'api/user_games#play'
  patch 'move', to: 'api/user_games#move'
  post 'fire_bullet', to: 'api/user_games#fire_bullet'
  patch 'reject', to: 'api/games#reject'
  # resources :account_activations, only: [:edit]

  mount ActionCable.server => '/cable'
end
