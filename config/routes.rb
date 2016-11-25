Rails.application.routes.draw do
    
    resources :stories
    devise_for :users
    resources :users
    resources :products
    root 'index#index'

end