Clobber::Application.routes.draw do
  get 'sessions/new'
  
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :messages, :only => [:new, :create]
  
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  root :to => 'pages#home'
end
