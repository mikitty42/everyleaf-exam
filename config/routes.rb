Rails.application.routes.draw do
  resources :users, only: [:new,:create,:show]
    namespace :admin do
      resources :users,only: [:index,:new,:create,:edit,:update,:destroy]
    end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  root to: 'tasks#index'
end
