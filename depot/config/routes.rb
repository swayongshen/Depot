Rails.application.routes.draw do
  resources :genres do
    collection do
      get '/', to: 'genres#index'
      match '/new', to: 'genres#create', via: [:get, :post]
    end
    member do
      get '/', to: 'genres#show'
      match '/edit', to: 'genres#edit', via: [:get, :patch]
      match '/delete', to: 'genres#delete', via: [:get, :delete]
    end
  end

  resources :orders, except: [:edit, :destroy, :update] do
    member do
      get 'ship'
    end
    collection do
      get 'filter'
    end
  end

  devise_for :users
  resources :line_items, only: [:create]
  resources :carts, only: [:destroy]
  root 'store#index', as: 'store_index'


  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
