Rails.application.routes.draw do
  root to: 'welcomes#index'

  devise_for :patients
  devise_for :doctors

  resources :slots
  resources :appointments
end