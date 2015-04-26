Rails.application.routes.draw do
  resources :posts

  devise_for :users

  post 'contact' => 'messages#create', :as => 'contact'

  get "/*id" => 'pages#show', as: :page, format: false
  root to: 'posts#index'
end
