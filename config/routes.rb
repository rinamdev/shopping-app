Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index'
  # Defines the root path route ("/")
  # root "articles#index"
  resources :products
  resources :lineitems
  resources :home
  get '/payment', to: 'lineitems#payment'
  get '/order_details', to: 'lineitems#order_detail'
  patch '/place_order', to: 'lineitems#place_order'
end
