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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    get 'users/index'
    get 'users/show'

    get 'homes/top'
  end

  scope :public do
    get 'packs/index'
    get 'packs/show'

    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'

    get 'users/show'
    get 'users/edit'

    get 'homes/top'
    get 'homes/map'
  end
end





