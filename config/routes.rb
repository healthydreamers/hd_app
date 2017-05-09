Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  root to: "dashboard#index"
  
  resources :topics, only: [:show]
  
  resources :articles, except: [:edit, :update, :destroy] do
    collection do
    	post '/url_lookup', to: 'articles#url_lookup', as: :url_lookup
    end
    member do
      #put "like",    to: "posts#upvote"
      #put "dislike", to: "posts#downvote"
    end
    resources :comments, module: :articles
  end
end
