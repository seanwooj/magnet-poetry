MagnetPoetry::Application.routes.draw do

  get "users/new"

  get "users/show"

  get "users/index"

  match '/', to: 'static_pages#home'
  match 'signup', to: 'users#new'

  get "static_pages/about"

end
