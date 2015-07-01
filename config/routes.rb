Rails.application.routes.draw do
  resources :templates
  resources :stories
  resources :resources

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  root 'home#index'
end
