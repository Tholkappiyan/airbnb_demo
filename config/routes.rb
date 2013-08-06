AirbnbDemo::Application.routes.draw do

  resources :properties do
    resources :bookings
  end

  resources :users
  resources :properties
  resources :bookings
  resources :user_sessions

  root to: 'users#home'
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'user_sessions#new'
  match '/signout', to: 'user_sessions#destroy', via: :delete
  match '/delete_property', to: 'properties#destroy', via: :delete
  match '/search', to: 'properties#search'
  match '/unbook_property', to: 'bookings#destroy', via: :delete
  match 'properties/:id/history' => 'bookings#search' , :as => 'booking_history'
end