Rails.application.routes.draw do


  get 'new/index'
  root 'pages#index'
  get 'menus/new'
  get 'comments/new'
  get 'workouts/new'
  get 'sessions/new'
  get 'users/new'
  get 'pages/index'
  get 'pages/help'
  get    'likes/index' #いいね一覧ページ
  post   '/likes', to: 'likes#create'  #いいね作成
  delete '/likes', to: 'likes#destroy' #いいね解除
  
  get    '/login',  to: 'sessions#new'     #ログインフォームを表示するページを取得
  post   '/login',  to: 'sessions#create'  #入力されたデータを元にSessionを作成
  delete '/logout', to: 'sessions#destroy' #Sessionを削除する
  
  get    '/comment/new',      to: 'comment#new'
  post   '/comments/new',     to: 'comments#create'
  delete '/workouts/:workout_id/comments/destroy', to: 'comments#destroy'
  
  resources :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :weights
  resources :workouts
  resources :menus
  resources :relationships, only: [:create, :destroy]
end
