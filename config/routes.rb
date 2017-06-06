Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  root to: "topics#index"
  
  resources :topics, only: [:index, :show]
  
  resources :articles, except: [:index, :edit, :update, :destroy] do
    collection do
    	#post '/url_lookup', to: 'articles#url_lookup', as: :url_lookup
    end
    member do
      put "like", to: "articles#upvote"
    end
    resources :comments, module: :articles
  end

  namespace :profile, path: '/profile' do
    # Dashboard
    resources :dashboard, only: [:index], path: 'me'
  end

end
