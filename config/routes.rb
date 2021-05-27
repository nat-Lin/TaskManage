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

  # error route
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unacceptable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
