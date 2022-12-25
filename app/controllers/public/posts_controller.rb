class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @post.routes.build
    @posts = current_user.posts
  end

  def confirm
    @post = Post.new(post_params)
    @posts = current_user.posts.all
  end

  def create
    @post = Post.new(post_params)
    if @post.user_id = current_user.id
      @post.save
    else
      render :new
    end
    redirect_to new_post_path
  end

  def index

  end

  def show

  end

  def edit

  end

  private

	def post_params
	    params.require(:post).permit(:title,
	    routes_attributes: [:spot, :date, :time, :image, :caption]
	    )
	end

end
