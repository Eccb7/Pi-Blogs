Rails.application.routes.draw do
  devise_scope :user do
    devise_for :users

    authenticated :user do
      root "users#index", as: :authenticated_root
    end

    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  namespace :api, defaults: { format: 'json' } do
    resources :users, only: [] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      member do
        post 'like', to: 'posts#like', as: 'like_post'
      end
    end
  end
end
