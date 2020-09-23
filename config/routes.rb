Rails.application.routes.draw do
  resources :tasks
  root to: 'tasks#index'
  post "/search" => "post#search"
end
