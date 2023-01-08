class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post = Post.find(params[:id])
    @posts = @user.posts.published.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    if @user = current_user
      @user.update(user_params)
      flash[:success] = 'You have updated user successfully.'
      redirect_to user_path(@user)
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :country, :one_word, :is_deleted)
  end

end
