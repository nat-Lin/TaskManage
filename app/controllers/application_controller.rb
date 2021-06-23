class ApplicationController < ActionController::Base
  before_action :authorize
  helper_method :current_user

  def current_user
    return unless session[:task_user_id]
    @current_user ||= User.find_by_id(session[:task_user_id])
  end

  private
    def authorize
      unless current_user
        flash[:notice] = '請登入後使用'
        redirect_to new_session_path
      end
    end

    def authorize_adimin
      unless current_user.admin?
        flash[:error] = '你無權使用此部分'
        redirect_to root_path
      end
    end
end
