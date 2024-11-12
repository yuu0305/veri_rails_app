Rails.application.routes.draw do
  # resources :posts, only: [:index, :create]
  resources :posts
  get 'static_pages/home'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
