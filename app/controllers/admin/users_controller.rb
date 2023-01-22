class Admin::UsersController < ApplicationController
  def index
    @users = Users.all
  end

  def show

  end
end
