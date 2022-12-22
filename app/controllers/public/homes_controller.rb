class Public::HomesController < ApplicationController
  def top
    @user = current_user.name
  end

  def map
  end
end
