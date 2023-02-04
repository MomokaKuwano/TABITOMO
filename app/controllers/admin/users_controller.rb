class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.is_deleted == false
      user.update(is_deleted: true)
    else
      user.update(is_deleted: false)
    end
    redirect_to admin_user_path(user.id)
  end

end
