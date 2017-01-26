Rails.application.routes.draw do

  root to: 'movies#index'

  resources :movies
  resources :directors, only: [:index, :show]

  get 'searchresults', to: 'movies#search'
  get 'search', to: 'searches#new', as: :new_search
  get 'results', to: 'searches#results'
  get 'directors', to: 'directors#index'
  get 'movies/directors/:id', to: 'directors#show'

  post 'add/:imdb_id', to: 'movies#add', as: :add_to_database

  # Replaced these with "resources :movies"
  # get 'movies', to: 'movies#index', as: :movies
  # get 'movies/:id', to: 'movies#show', as: :movie
  # get 'movies/new', to: 'movies#new', as: :new_movie
  # get 'movies/:id/edit', to: 'movies#edit', as: :edit_movie
  # post 'movies', to: 'movies#create'
  # patch 'movies/:id', to: 'movies#update'
  # delete 'movies/:id', to: 'movies#destroy'

end
