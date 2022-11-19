Rails.application.routes.draw do
  root "posts#index"
  resources :posts

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'

  get '/dashboard' => 'dashboard#show'

  get '/home' => 'home#index'
end
