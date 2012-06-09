Mixxy::Application.routes.draw do
  

  

  resources :playlists

  root to: "static#home"

  resources :users, :only => [ :show, :edit, :update ]

  match '/auth/:provider/callback' => 'sessions#create'
  match '/service/:provider/callback' => 'users#add_service'

  match '/signin' => 'sessions#new', :as => :signin

  match '/signout' => 'sessions#destroy', :as => :signout

  match '/auth/failure' => 'sessions#failure'

  root :to => "home#index"

end
