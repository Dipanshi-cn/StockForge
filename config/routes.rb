Rails.application.routes.draw do
  devise_for :users
  
  root "products#index"

  resources :categories, only: [:index, :show]
  resources :products, only: [:index, :show] do
    collection do
      get :search
    end
  end
  
  resource :cart, only: [:show] do
    resources :items, controller: 'cart_items', only: [:create, :update, :destroy]
  end

  resources :orders, only: [:index, :show, :create, :new]

  namespace :admin do
    root to: "dashboard#index"
    resources :categories
    resources :products
    resources :orders, only: [:index, :show] do
      member do
        patch :approve
        patch :reject
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
