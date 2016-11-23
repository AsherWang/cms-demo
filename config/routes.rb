Rails.application.routes.draw do

  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  resources :products
  get '/products/index/ajax',to:"products#index_ajax"
  resources :products
      # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # You can have the root of your site routed with "root"
    root 'index#index'
    get '/',to:"index#index"


    get '/table', to: 'table#demo'

    # get '/stories/scheme', to: 'stories#scheme'
    # resources :stories, except: [:new, :edits]

    get '/demos/index_ajax', to: 'demos#index_ajax'
  end
