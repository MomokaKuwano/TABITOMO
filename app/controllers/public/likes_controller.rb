class Public::LikesController < ApplicationController
  
  def index
    @user = User.find(params[:id])
    # @userで絞ったユーザーの投稿一覧
    @posts = @user.posts.published.page(params[:page])
    @users = @user.followings.page(params[:user_page]).per(5)
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end
  
  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: post.id)
    like.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: post.id)
    like.destroy
    redirect_to post_path(post)
  end
  
end
