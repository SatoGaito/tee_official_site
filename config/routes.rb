Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'event_calenders#index'
  get 'homes/about', to: 'homes#about'
  resources  :users, only: [:index, :show, :edit, :update]
  resources :events do
    resources :event_comments, only: [:create, :destroy]
  end
  resources :tweets do
    resources :tweet_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :event_calenders
end
