Rails.application.routes.draw do
    
  devise_for :users
  resources :users
  resources :products
      # index,show,new,create,edit,update,destroy,  
    # and index_ajax ,get list(item in list with general info),support basic query params
    root 'index#index'

end