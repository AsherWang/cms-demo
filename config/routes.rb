Rails.application.routes.draw do
    
    devise_for :users
    resources :users
    resources :stories
    resources :products
    root 'index#index'

end