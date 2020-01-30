Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about'
  resources  :users, only: [:index, :show, :edit, :update]
  resources :events do
    resources :event_comments, only: [:create, :destroy]
  end
end
