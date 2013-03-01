MagnetPoetry::Application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, :words, :poem_words
  resources :poems do
    member do
      post 'spawn_new_words'
      post 'submit'
    end
  end
  resources :games, only: [:show]


  root to: 'static_pages#home'

  get 'signup', to: redirect("/users/sign_up")
  get 'signin', to: redirect("/users/sign_in")

  get "static_pages/about"
end
