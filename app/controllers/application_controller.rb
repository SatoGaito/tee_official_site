class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :login

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      flash[:notice] = "登録完了しました。プロフィール登録をお願いします。" 
      edit_user_path(current_user)
    else
      flash[:notice] = "ログインに成功しました。" 
      user_path(current_user)  
    end
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました。"   
    root_path
  end

  def login
    if session[:user_id].blank?
      user = User.create
      session[:user_id] = user.id
    end
    @user_id = session[:user_id]
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
