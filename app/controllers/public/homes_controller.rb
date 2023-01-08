class Public::HomesController < ApplicationController
  def top
    @user = current_user
    @posts = Post.published.page(params[:post_page])
    # ユーザー検索
    if params[:name].present?
       @users = User.where('name LIKE ?', "%#{params[:name]}%").page(params[:user_page]).per(5)
    # elsif
      # ルートの検索の場合のif文
    else
      @users = User.page(params[:user_page]).per(5)
    end
  end

  def map
  end
end
