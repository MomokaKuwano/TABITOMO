class Public::HomesController < ApplicationController
  def top
    @posts = Post.published
    @user = current_user.name
  end

  def map
  end
end
