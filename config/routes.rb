Mixxy::Application.routes.draw do
  

  

  resources :playlists

  root to: "static#home"

  resources :users, :only => [ :show, :edit, :update ]

  match '/auth/:provider/callback' => 'sessions#create'
  match '/service/:provider/callback' => 'users#add_service'

  match '/signin' => 'sessions#new', :as => :signin

  match '/signout' => 'sessions#destroy', :as => :signout

  match '/auth/failure' => 'sessions#failure'
  
  match '/me' => 'users#me'
  
  match '/api/blended_search' => 'api#blended_playlist_search'
  match '/api/like' => 'api#like_playlist'
  match '/api/add' => 'api#add_playlist'
  match '/api/add/spotify' => 'api#add_spotify_playlist'
  match '/api/get_sc_followings_playlists' => 'users#get_sc_followings_playlists'
  match '/api/browse/rdio' => 'users#get_rdio_playlists'
  match '/api/browse/soundcloud' => 'users#get_sc_followings_playlists'
  match '/api/browse/youtube' => 'users#get_youtube_playlists'

  root :to => "home#index"

end
