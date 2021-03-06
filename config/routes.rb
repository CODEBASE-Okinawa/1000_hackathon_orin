Rails.application.routes.draw do
  root 'sessions#new'

  post 'tasks/:id/toggle', to: 'tasks#toggle'
  resources :tasks

  get '/signup', to: 'users#new'
  get '/profile', to: 'users#profile'
  get '/profile/edit', to: 'users#edit'
  post '/user/update', to: 'users#update_from_project'
  resources :users, except: %i(new edit)

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  resources :comments, only: %i(create)

  post '/list/update', to: 'lists#update_from_project'
  resources :lists

  resources :projects, only: %i(index create show)
end
