Rails.application.routes.draw do
  root "movies#index"
  resources:movies do
    resources :reviews
    resources :favorites
  end
  resources :users
  resource :session
  resources :genres
  get "signup" => "users#new"
  get "signin" => "sessions#new"
end
