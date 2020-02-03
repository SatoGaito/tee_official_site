class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      flash[:notice] = "登録完了しました。プロフィール登録をお願いします。" 
      edit_user_path(current_user)
    else
      flash[:notice] = "ログインに成功しました" 
      user_path(current_user)  
    end
  end

end
