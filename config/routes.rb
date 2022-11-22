Rails.application.routes.draw do
  get 'restaurants/new'
  get 'sessions/new'
  get 'users/new'
  root "static_pages#home"
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get  "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers, :restaurant_following
    end
  end
  resources :restaurants do
    member do
      get :restaurant_followers
    end
  end
  resources :microposts,                only: [:create, :destroy]
  resources :relationships,             only: [:create, :destroy]
  resources :restaurant_relationships,  only: [:create, :destroy]
  get '/microposts', to: 'static_pages#home'
end
