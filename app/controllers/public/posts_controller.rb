class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_customer.id
    @post.save
    redirect_to post_path
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
	    
	end
	
end
