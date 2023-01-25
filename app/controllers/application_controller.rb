class ApplicationController < ActionController::Base
  # ログイン認証が成功していないと、トップページ以外の画面は表示できない仕様

  before_action :authenticate_user!, except: [:top], unless: :admin_signed_in?
  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行
  before_action :configure_permitted_parameters, if: :devise_controller?
  # サインイン後の遷移ページ
  def after_sign_in_path_for(resource)
    root_path
  end
  # サインアウト後の遷移ページ
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    # ユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント編集の時にnameとcountryとone_wordのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :country, :one_word, :profile_image])
  end
end
