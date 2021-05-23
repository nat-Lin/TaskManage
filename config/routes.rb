# == Route Map
#

Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :tags, except: [:new, :edit, :show]
  resources :registers, only: [:new, :create, :update, :destroy], controller: 'users'
  resource :session, only: [:new, :create, :destroy]

  namespace :admin do 
    root 'users#index'
    resources :users, only: [:index, :show]
  end
end
