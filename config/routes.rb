MagnetPoetry::Application.routes.draw do

  devise_for :users
  resources :users, :words, :poem_words
  resources :poems do
    member do
      post 'spawn_new_words'
      get 'refresh_words'
    end
  end


  root to: 'static_pages#home'

  get 'signup', to: redirect("/users/sign_up")
  get 'signin', to: redirect("/users/sign_in")

  get "static_pages/about"
end
