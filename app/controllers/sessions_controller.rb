class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_name(params[:name])

    if user && user.authenticate(params[:password])
      session[:task_user_id] = user.id
      flash[:notice] = i18n_t('.create_successful', user: user.name)
      redirect_to root_path
    else
      flash[:error] = i18n_t('.create_failed')
      redirect_to new_session_path
    end
  end

  def destroy
    session[:task_user_id] = nil
    flash[:notice] = i18n_t('.destroy_successful')
    redirect_to new_session_path
  end
  private
    def i18n_t(key, **options)
      I18n.t(key, scope: 'sessions.controllers', user: options[:user])
    end
end