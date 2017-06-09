Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, controllers: { sessions: "users/sessions"}
  root "pages#show", page: "home"
  get "pages/*page" => "pages#show"
  get "pages/help"
  get "pages/about"
  get "pages/contact"
  get "pages/product"

  resources :users, only: [:index, :show, :destroy, :update] do
    resources :relationships, only: :index
    resources :products, only: :index
  end
  resources :relationships, only: [:create, :destroy]
  resources :products, except: :index do
    resources :comment_products, only: [:create, :update, :destroy]
  end
  resources :likeships, only: [:create, :destroy]
  resources :feedbacks, only: [:new, :create]
  namespace :admin do
    resources :feedbacks, only: [:index, :show, :destroy]
    resources :categories
  end
  resource :order, only: :show
  resources :order_items, only: [:create, :update, :destroy]
end
