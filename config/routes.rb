Rails.application.routes.draw do


  devise_for :users, path: 'auth', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, defaults: { format: :json }
  delete '/auth/logout', to: 'users/sessions#destroy', as: 'logout'

  

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    member do
      get :followers
      get :followings
    end
  end

  resources :posts, only: [:index, :create, :show, :update, :destroy] do
    resources :comments, only: [:index, :create]
  end

  resources :follows, only: [:create, :destroy]

  # para indicar que existe o no una ruta
  match '*unmatched_route', to: 'application#route_not_found', via: :all

end
