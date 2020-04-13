Rails.application.routes.draw do
  resources :arrivaltimes
  resources :trainlines
  resources :arrivals
  resources :stops
  resources :favorites
  resources :users
  get '/get_status', :to => 'favorites#get_status' 
  post '/signup', :to => 'users#signup'
  post '/login', :to => 'users#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
