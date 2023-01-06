Rails.application.routes.draw do
  devise_for :users
  root to: "pokemons#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  resources :pokemons do
    resources :deals, only: %i[new create]
  end

  resources :deals, only: %i[show edit update]
  get "my_deals", to: "deals#my_deals"
end
