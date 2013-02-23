MagnetPoetry::Application.routes.draw do



  match '/', to: 'static_pages#home'

  get "static_pages/about"

end
