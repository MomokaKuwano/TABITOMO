class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @posts = @user.posts.published
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

  # 検索機能
  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.none
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :country, :one_word, :is_deleted)
  end

end
