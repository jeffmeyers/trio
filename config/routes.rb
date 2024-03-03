Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "pages#index"

  resources :games, only: [:show, :create] do
    post :start, on: :member
    post :action, on: :member
  end

  resources :players, only: [:create]
end
