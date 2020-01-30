Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about'
  resources  :users
end
