class Public::HomesController < ApplicationController
  def top
    @posts = Post.published
  end

  def map
  end
end
