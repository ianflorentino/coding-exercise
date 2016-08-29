Rails.application.routes.draw do
  resources :users, except: [:create]

  resources :tasks
  post '/tasks/:id/assign', to: 'tasks#assign_task', as: 'assign'
  post '/tasks/:id/unassign', to: 'tasks#unassign_task', as: 'unassign'

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#logout', as: 'logout', via: [:get, :delete]

  get '/', to: 'frontend#index'
end
