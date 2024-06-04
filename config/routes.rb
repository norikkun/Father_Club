Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to:'homes#top'
    get '/about' => 'homes#about'
    get 'users/:user_id/posts' => 'users#index'
    get 'users/:user_id/follower' => 'users#follower'
    get 'users/:user_id/followed' => 'users#followed'
    get 'users/comfirm' => 'users#comfirm'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users , only: [:edit, :show, :update]
    resources :posts , only: [:new, :show, :create, :edit, :update, :destroy] do
      resources :comments , only: [:new, :create, :edit, :update, :destroy]
      resource :favorites , only: [:index, :create, :destroy]
    end
    resources :relationships , only: [:create, :destroy]
    get 'searches' => 'searches#search'
    get "users" => redirect("/users/sign_up")
  end
  
  namespace :admin do
    get '/' => 'homes#top'
    # 各ユーザーの投稿一覧
    get '/admin/users/:users_id/posts' => 'users#list'
    resources :users , only: [:edit, :index, :show, :update]
    resources :posts , only: [:show, :update, :destroy]
    resources :comment , only: [:destroy]
    get 'searches' => 'searches#search'
    
    
  end
end
