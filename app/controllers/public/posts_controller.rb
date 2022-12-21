class Public::PostsController < ApplicationController
  def new
  end

  def index
  end

  def show
  end

  def edit
  end
  
  private
	def post_params
	    params.require(:post).permit(:title, :image)
	end
	
end
