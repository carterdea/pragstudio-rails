Rails.application.routes.draw do
  resources :users
  root "events#index"
  
  resources:events do
    resources:registrations
  end
  resource :session
  get "signup" => "users#new"
  get "signin" => "sessions#new"
end
