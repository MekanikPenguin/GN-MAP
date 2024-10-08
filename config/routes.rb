Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :messages, only: [:index, :show, :new, :create]

  resources :users, only: :show do
    member do
      post 'report'
      post 'block'
    end
  end

  resources :events do
    resources :subs, only: [:create, :destroy]
    resources :reviews, only: :create
    resources :follows, only: [:create, :destroy]
  end

  namespace :account do
    resources :subscriptions, only: :index
    resources :events, only: :index
    resources :follows, only: [:index, :destroy]

    root controller: :subscriptions, action: :index
  end

  namespace :account do
    resources :subscriptions, only: [] do
      member do
        patch 'accept'
        patch 'reject'
      end
    end
  end
end
