require 'sidekiq/web'

Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'      
  post 'signup', to: 'users#create'                 

  resources :users
  resources :sessions
  
  # User login/logout routes
  get 'login', to: 'sessions#new', as: 'login'      
  post 'login', to: 'sessions#create'                
  get 'logout', to: 'sessions#destroy', as: 'logout' 

  # Books Board
  root 'books_board#index'

  # Index page
  resources :books

  # Sidekiq TEsting
  get 'sidekiq_testing', to: 'sidekiq_testing#index'
  get 'perform_sidekiq_task', to: 'sidekiq_testing#perform_sidekiq_task'
  get 'perform_sidekiq_task_later', to: 'sidekiq_testing#perform_sidekiq_task_later'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  mount Sidekiq::Web => "/sidekiq"
end
