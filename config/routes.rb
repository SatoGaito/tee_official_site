Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users(:users,
    controllers: {
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    })
  root to: 'event_calenders#index'
  get 'about', to: 'users#about'
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
