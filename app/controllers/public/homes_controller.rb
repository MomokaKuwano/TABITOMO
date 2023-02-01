class Public::HomesController < ApplicationController
  def top
    @user = current_user
    @posts = Post.published.page(params[:post_page])
    # ユーザー検索
    if params[:name].present?
       @users = User.where('name LIKE ?', "%#{params[:name]}%").page(params[:user_page]).per(9)
    else
      @users = User.page(params[:user_page]).per(9)
    end
    # スポット検索
    if params[:keyword].present?
      # postテーブルとrouteテーブルを結合する
      @posts = Post.joins(:routes).published.where('routes.spot LIKE ?', "%#{params[:keyword]}%").page(params[:post_page])
    else
      @posts = Post.published.page(params[:post_page])
    end
  end

end