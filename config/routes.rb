Rails.application.routes.draw do
  resources :cart_items
  resources :order_items
  resources :carts
  resources :line_items
  resources :orders
  resources :products
  resources :sellers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
