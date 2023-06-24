Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :create] do
    member do
      get :followers
      get :followings
    end
  end

  resources :posts, only: [:index, :create, :show] do
    resources :comments, only: [:index, :create]
  end

  resources :follows, only: [:create, :destroy]
end
