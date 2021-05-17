Rails.application.routes.draw do
  resources :orders do
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
