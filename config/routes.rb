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
    resources :users, only: [:show, :edit]
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :packs, only: [:index, :show]
  end
end





