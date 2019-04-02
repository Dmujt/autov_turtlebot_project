Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :passwords], controllers: {
    registrations: 'users/registrations',
    passwords:'users/passwords',
    sessions: 'users/sessions',
    confirmations:'users/confirmations'}

  root to: 'home#index'

  namespace :api do

  end

  match '/*path', to: 'home#index', via: :get
  
end
