Rails.application.routes.draw do
  resources :tasks do
    get :search,on: :collection
  end
  root to: 'tasks#index'
end
