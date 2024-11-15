Rails.application.routes.draw do
  get 'static_pages/about'
  # You can make it prettier with:
  get 'about', to: 'static_pages#about'
  resources :users
end
