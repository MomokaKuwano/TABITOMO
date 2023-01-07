class Public::HomesController < ApplicationController
  def top
    # binding.pry
    if params[:name].present?
       @users = User.where('name LIKE ?', "%#{params[:name]}%")
    # elsif　
      # ルートの検索の場合のif文
    else
      @users = User.all
    end
    @posts = Post.published
    @user = current_user
  end

  def map
  end
end
