Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/help'
  get 'likes/index'
  post '/likes', to: 'likes#create'
  delete '/likes', to: 'likes#destroy'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/comment/new', to: 'comment#new'
  post '/comments/new', to: 'comments#create'
  delete '/workouts/:workout_id/comments/destroy', to: 'comments#destroy'
  
  resources :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :workouts
  resources :menus
  resources :relationships, only: [:create, :destroy]
end
