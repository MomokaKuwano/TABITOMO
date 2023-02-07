Rails.application.routes.draw do
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  # 顧客用
# URL /customers/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

 # URLは変えない/ファイル構成だけ指定のパス
  scope module: :public do
    root to: 'homes#top'
    resources :users, only: [:show, :edit, :update] do
      patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
      resource :relationships, only: [:create, :destroy]
    end
    resources :lists, only: [:create, :index, :show, :edit, :update, :destroy]
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      get 'edit_detail/:route_id' => 'posts#edit_detail', as: 'edit_detail'
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    delete '/posts/:id/destroy_post' =>'posts#destroy_post', as: 'destroy_post'
  end

  #URLは指定のパス/ファイル構成も指定のパス
  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
  end

end





