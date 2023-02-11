Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :home, only: [:index]
  resources :users, only: [:new, :create, :index, :show] do
    resource :profile, only: [:new, :create, :show]
  end
end
