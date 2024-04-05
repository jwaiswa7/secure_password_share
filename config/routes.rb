# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'secrets#new'

  resources :secrets, only: %i[new create] do
    resources :accesses, only: %i[new create]
  end
end
