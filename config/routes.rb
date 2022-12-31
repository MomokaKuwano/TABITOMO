Rails.application.routes.draw do
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
    root to:'homes#top'
    resources :users, only: [:index, :show]
  end

 # URLは変えない/ファイル構成だけ指定のパス
  scope module: :public do
    root to:'homes#top'
    get 'homes/map' => 'homes#map', as: 'map'
    get 'users/show' => 'users#show', as: 'mypage'
    patch 'users/destroy' => 'users#destroy', as: 'unsubscribe'
    resources :users, only: [:edit, :update]
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    end
    resources :packs, only: [:index, :show]
  end
end





