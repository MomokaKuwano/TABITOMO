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
#URLは指定のパスにしたい/ファイル構成も指定のパスにしたい
  namespace :admin do
    get 'users/index'
    get 'users/show'

    get 'homes/top'
  end
 
 # URLは変えたくない/ファイル構成だけ指定のパスにしたい
  scope module: :public do
    root to:'homes#top'
    get 'packs/index'
    get 'packs/show'

    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'

    get 'users/show'
    get 'users/edit'

    get 'homes/map'
  end
end





