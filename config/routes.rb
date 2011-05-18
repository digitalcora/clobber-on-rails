Clobber::Application.routes.draw do
  resources :users
  resources :sessions,   :only => [:new, :create, :destroy]
  resources :messages,   :only => [:create]
  resources :challenges, :only => [:create, :destroy]
  resources :games,      :only => [:show, :create] do
    resources :pieces,     :only => [:edit, :update],
                           :controller => 'games'
  end
  # FIXME - Breaks REST, but link_to doesn't work in SVG
  match 'games/:game_id/pieces/:id/update' => 'games#update', :as => :update_piece
  
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  root :to => 'pages#home'
end
