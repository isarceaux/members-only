Rails.application.routes.draw do
  
  get 'posts/new'

  root 'posts#index'

  resources :users
  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/new_post', to:'posts#new'
  post '/new_post', to:'posts#create'
  #get '/posts', to:'posts#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
