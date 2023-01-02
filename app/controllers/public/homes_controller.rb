class Public::HomesController < ApplicationController
  def top
    @posts = Post.published
    @user = current_user
    @users = User.all
  end

  def map
  end
end
