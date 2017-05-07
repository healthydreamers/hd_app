Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  root to: "dashboard#index"
  resources :articles, except: [:destroy]
  resources :topics, only: [:show]
  match '/articles/url_lookup/' => 'articles#url_lookup', :as => :url_lookup, :via => :post
end
