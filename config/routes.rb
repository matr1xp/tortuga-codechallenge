Rails.application.routes.draw do
  root to: 'members#index'
  get 'friendships/select/:id', to: 'friendships#select'
  resources :friendships
  resources :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
