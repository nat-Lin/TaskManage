# == Route Map
#

Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resource :register, only:[:new, :create], controller: 'users'
end
