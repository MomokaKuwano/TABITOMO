class Public::UsersController < ApplicationController
  before_action :ensure_normal_user, only: %i[withdrawal edit update show]
  before_action :ensure_login_user, only: %i[show]

  def show
    @user = User.find(params[:id])
    # @userで絞ったユーザーの投稿一覧
    @posts = @user.posts.published.page(params[:page])
    @users = @user.followings.page(params[:user_page]).per(5)
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
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

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:success] = 'Withdrawal process completed.'
    redirect_to root_path
  end

  private


  def ensure_normal_user
    if current_user.email === 'guest@example.com'
      redirect_to root_path
    end
  end

  # ログインしているユーザーが他のユーザーの登録情報をみれないようにする
   # current_userのIDと URLのusers/:id 同じだったら,MYPAGEを表示してOK
  # current_userのIDと URLのusers/:idが同じじゃなかったら,rootパスに戻す
  def ensure_login_user
    if current_user.id != params[:id].to_i
      redirect_to root_path
    end
  end


  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :country, :one_word, :is_deleted)
  end

end
