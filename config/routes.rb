Rails.application.routes.draw do
    
  resources :stories
  devise_for :admins
  resources :permissions
  resources :roles
  resources :admins
  root 'index#index'

end