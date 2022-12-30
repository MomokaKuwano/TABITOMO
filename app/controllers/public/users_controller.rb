class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @posts = @user.posts.published
  end

  def edit
    @user = current_user
  end
    
  def update
    user.update(user_params)
    redirect_to mypage_path
  end
end
