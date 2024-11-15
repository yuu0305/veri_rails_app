Rails.application.routes.draw do
  resources :products
  get 'pages/home'
  get 'pages/about'
  get 'pages/contact'
  get 'pages/services'
  get 'static_pages/about'
  # You can make it prettier with:
  get 'about', to: 'static_pages#about'
  resources :users
end
