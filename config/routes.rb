Rails.application.routes.draw do
    
    devise_for :users
    resources :users
    resources :storiess
    resources :products
    root 'index#index'

end