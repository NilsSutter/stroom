Rails.application.routes.draw do
  devise_for :users
  root to: 'stations#home'
  resources :stations do
    resources :bookings, only: [:new, :create, :destroy, :show]
  end

  resources :bookings do
    resources :reviews, only: [:new, :create, :destroy]
  end
  get 'stations/:city', to: 'stations#search', as: 'stations_city'
  get 'stations/:id/photo-remove', to: 'stations#delete_photo', as: 'delete_photo'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
