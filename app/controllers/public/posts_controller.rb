class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @post.routes.build
    @posts = current_user.posts
    @statuses = current_user.statuses
  end

  def status
    @status = Status.new(status_params)
    if @status.user_id = current_user.id
      @status.save
    else
      render :new
    end
    redirect_to new_post_path
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

  def update
    status = Status.find(params[:id])
    status.user_id = current_user.id
    status.update(status_params)
    redirect_to new_post_path
  end

  def destroy
    status = Status.find(params[:id])
    status.user_id = current_user.id
    status.destroy
    redirect_to new_post_path
  end

  private

	def status_params
	    params.permit(:spot, :date, :time, :image, :caption)
	end

end
