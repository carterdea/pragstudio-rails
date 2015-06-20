Rails.application.routes.draw do
  root "movies#index"

  get "movies/filter/:scope" => "movies#index", as: :filtered_movies

  %w(hits flops upcoming recent).each do |scope|
    get "movies/#{scope}" => redirect("/movies/filter/#{scope}")
  end

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
