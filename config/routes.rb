Rails.application.routes.draw do
  resources :roles
  resources :permissions
  devise_for :admins
  resources :admins
  resources :stories
  resources :products
  root 'index#index'

end