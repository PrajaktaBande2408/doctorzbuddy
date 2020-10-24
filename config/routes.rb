Rails.application.routes.draw do
  root to: 'welcomes#index'

  devise_for :patients
  devise_for :doctors

  resources :slots do
    post :book, on: :member
  end
  resources :appointments
end