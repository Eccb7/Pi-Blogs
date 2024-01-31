Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      member do
        post 'like', to: 'posts#like', as: 'like_post'
      end
    end
  end
end
