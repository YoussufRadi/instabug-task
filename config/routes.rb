
Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
  
  resources :users
  resources :chats do
    resources :messages
  end
  delete '/users', to: 'users#destroy'
  patch '/users', to: 'users#update'
  
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
