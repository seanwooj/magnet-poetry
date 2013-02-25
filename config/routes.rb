MagnetPoetry::Application.routes.draw do

  devise_for :users
  resources :users

  root to: 'static_pages#home'

  get 'signup', to: redirect("/users/sign_up")
  get 'signin', to: redirect("/users/sign_in")

  get "static_pages/about"

end
