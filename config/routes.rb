Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :user_games, only: [:index, :new, :create, :destroy]
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
  # resources :account_activations, only: [:edit]

  mount ActionCable.server => '/cable'
end
