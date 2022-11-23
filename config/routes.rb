Rails.application.routes.draw do
  root   'static_pages#home'
  get    'restaurants/new'
  get    'sessions/new'
  get    'users/new'
  get    '/help',        to: 'static_pages#help'
  get    '/about',       to: 'static_pages#about'
  get    '/contact',     to: 'static_pages#contact'
  get    '/leaderboard', to: 'restaurants#leaderboard'
  get    '/signup',      to: 'users#new'
  get    '/login',       to: 'sessions#new'
  post   '/login',       to: 'sessions#create'
  delete '/logout',      to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers, :restaurant_following, :liking
    end
  end
  resources :restaurants do
    member do
      get :restaurant_followers
    end
  end
  resources :microposts do
    member do
      get :likers
    end
  end
  resources :microposts,                only: [:create, :destroy]
  resources :relationships,             only: [:create, :destroy]
  resources :restaurant_relationships,  only: [:create, :destroy]
  get '/microposts', to: 'static_pages#home'
end
