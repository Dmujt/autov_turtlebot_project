Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :passwords], controllers: {
    registrations: 'users/registrations',
    passwords:'users/passwords',
    sessions: 'users/sessions',
    confirmations:'users/confirmations'}

  root to: 'home#index'

  namespace :api do
    get '/turtlebot_registrations' => 'turtlebot_registrations#index'
    
    resources :pickup_requests, only: [:index, :show, :create, :update]
    scope '/pickup_requests' do
      get '/last' => 'pickup_requests#last'
      scope '/:id' do
        put '/cancel' => 'pickup_requests#cancel_state'
        put '/completed' => 'pickup_requests#complete_state'
      end
    end
  end

  match '/*path', to: 'home#index', via: :get
  
end
