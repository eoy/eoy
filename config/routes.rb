Rails.application.routes.draw do
  resources :posts

  devise_for :users

  get "/*id" => 'pages#show', as: :page, format: false
  root to: 'posts#index'
end
