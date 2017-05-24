Rails.application.routes.draw do
  root to: 'home#index'
  get "/check_for_updates" => "home#check_for_updates"
  devise_for :users

  resources :card_types

  #only api calls
  resources :slots do
    post :switch, on: :collection
  end
  resources :lists do
    post :switch, on: :collection
  end
  resources :cards
  resources :workflows do
    resources :milestones
  end


end
