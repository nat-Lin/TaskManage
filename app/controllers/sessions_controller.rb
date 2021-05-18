class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_name(params[:name])

    if user && user.authenticate(params[:password])
      session[:task_user_id] = user.id
      flash[:notice] = "歡迎回來 #{user.name}"
      redirect_to root_path
    else
      flash[:error] = '登入失敗，請再次嘗試'
      redirect_to new_session_path
    end
  end

  def destroy
    session[:task_user_id] = nil
    flash[:notice] = '成功登出'
    redirect_to root_path
  end
end