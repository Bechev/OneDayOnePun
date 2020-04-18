Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'puns#index'

  patch 'publish/:id', to: 'puns#publish'
  resources :puns

end
