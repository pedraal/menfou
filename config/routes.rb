Rails.application.routes.draw do
  root 'home#index'
  resources :posts
  resources :users do
    get :search, on: :collection
    put :follow, on: :member
    put :unfollow, on: :member
  end

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'

  get '/dashboard' => 'dashboard#show'

end
