Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout'  => 'sessions#destroy'
  get 'signup' => 'users#new'
  get 'search' => 'pages#search'
  
  resources :home, only: [:index]
  resource :profile, only: [:new, :create, :show]
  resolve("Profile") { [:profile] }
  resource :password_reset_token, only: [:new, :create]
  resources :sessions, only: [:new, :create] 
  resources :users, only: [:new, :create, :index, :show]
  resources :articles
end
