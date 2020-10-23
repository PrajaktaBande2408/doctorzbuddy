Rails.application.routes.draw do
  devise_for :patients
  devise_for :doctors
  root to: 'welcomes#index'
end