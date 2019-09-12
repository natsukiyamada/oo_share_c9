class SessionsController < ApplicationController
  skip_before_action :login_required
  
  def new
  end
  
  def create 
    user = User.find_by(mail: session_params[:mail])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "認証に成功しました"
    else
      flash.now[:alert] = "認証に失敗しました"
      render :new
    end 
  end
  
  def destroy
    reset_session
    flash.notice = "ログアウトしました"
		redirect_to root_url
  end
  
  private
  
  def session_params
    params.require(:session).permit(:mail, :password)
  end 

end
