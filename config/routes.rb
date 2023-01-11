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
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
#URLは指定のパス/ファイル構成も指定のパス
  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show]
  end

 # URLは変えない/ファイル構成だけ指定のパス
  scope module: :public do
    root to: 'homes#top'
    get 'homes/map' => 'homes#map', as: 'map'
    patch 'users/destroy' => 'users#destroy', as: 'unsubscribe'
    resources :users, only: [:show, :edit, :update]
    resources :users do
      resource :relationships, only: [:create, :destroy]
    end
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      get 'edit_detail/:route_id' => 'posts#edit_detail', as: 'edit_detail'
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :packs, only: [:index, :create, :show]
    resources :items, only: [:create, :inde]

  end
end





