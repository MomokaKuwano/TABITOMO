class Public::HomesController < ApplicationController
  def top
    @posts = Post.published
    @user = current_user
  end

  def map
  end
end
