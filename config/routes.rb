Rails.application.routes.draw do
  resources :templates
  resources :stories

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  root 'home#index'
end
