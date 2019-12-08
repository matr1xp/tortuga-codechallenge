Rails.application.routes.draw do
  #get 'search', to: 'search#index'
  get 'search/member/:id', to: 'search#member'
  post 'search/:id', to: 'search#create'
  root to: 'members#index'
  get 'friendships/select/:id', to: 'friendships#select'
  resources :friendships
  resources :members
  resources :search
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
