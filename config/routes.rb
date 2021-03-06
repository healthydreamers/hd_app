Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  root to: "topics#index"
  
  resources :topics, only: [:index, :show]
  get 'tags/:tag', to: 'articles#index', as: :tag
  
  resources :articles, except: [:index, :edit, :update, :destroy] do
    member do
      put "like", to: "articles#upvote"
    end
    resources :comments, module: :articles
  end

  namespace :profile, path: '/profile' do
    resources :dashboard, only: [:index], path: 'me'
  end

end
