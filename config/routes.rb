Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ..
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: 'homes#top'
    get 'users/:user_id/follower' => 'users#follower'
    get 'users/:user_id/followed' => 'users#followed'
    get 'users/confirm' => 'users#confirm'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users, only: [:edit, :show, :update] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
  	  get "followers" => "relationships#followers", as: "followers"
      get :favorites 
    end
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get 'search' => 'searches#search'
    get "users" => redirect("/users/sign_up")
  end
  
  namespace :admin do
    resources :users, only: [:edit, :index, :show, :update]
    resources :posts, only: [:update, :destroy,] do
      resources :comments, only: [:destroy]
    end
  end
end