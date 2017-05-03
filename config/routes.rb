Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :card_types

  #only api calls
  resources :slots
  resources :lists
  resources :cards


end
