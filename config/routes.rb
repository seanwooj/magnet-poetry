MagnetPoetry::Application.routes.draw do

  resources :users

  match '/', to: 'static_pages#home'
  match 'signup', to: 'users#new'

  get "static_pages/about"

end
