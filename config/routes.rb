Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'pages#welcome'
  get '/search' => 'pages#search'
  # get :autocomplete, to: 'pages#autocomplete'
  get '/suggestions-create', to: 'pages#build_suggestion'
  get '/suggestions', to: 'pages#get_suggestions'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
end
