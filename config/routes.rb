Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "dreams/activity", to: "dreams#activity", as: :dreams_activity
  get "labels/query", to: "labels#query", as: :labels_query
  get "profile", to: "pages#profile", as: :profile
  
  resources :dreams
  resources :labels, except: [:show]
end
