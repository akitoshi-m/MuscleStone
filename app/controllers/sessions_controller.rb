class SessionsController < ApplicationController
  def new
  end
  
  def create
    #フォームから送信されたメールアドレスを取得し、一致するユーザーがいるか検索
    user = User.find_by(email: session_params[:email])
    #「該当のメールアドレスを持つuserが存在している、かつuserのパスワードが正しい」場合true
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to user_path(user), success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to root_path, info: 'ログアウトしました'
  end
  
  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
    
  #log_inメソッドでsession[:user_id]にログイン情報を保存
  def log_in(user)
    session[:user_id] = user.id
  end
  #session.deleteメソッドでSessionを削除
  def log_out
    session.delete(:user_id) #セッションに保存されているuser_idを削除
    @current_user = nil #current_userを削除
  end
end
