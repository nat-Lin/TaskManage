class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :find_user, only: [:update, :destroy]
  before_action :verify_user, only: [:update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = i18n_t('.create_successful')
      redirect_to current_user.try('admin?') ? admin_root_path : new_session_path
    else
      render :new
    end
  end

  def update
    update_params = params.require(:user).permit(:role)
    @user.update(update_params) ? flash[:notice] = i18n_t('.update_successful') : flash[:error] = @user.errors[:role].join(',')
    redirect_to admin_root_path
  end

  def destroy
    @user.destroy ? flash[:notice] = i18n_t('.destroy_successful') : flash[:error] = @user.errors[:destroy].join(',')
    redirect_to admin_root_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    def find_user
      @user = User.find_by_id(params[:id])
    end

    def verify_user
      authorize_adimin
      if current_user == @user
        flash[:error] = i18n_t('.same_user_error')
        redirect_to admin_root_path
      end
    end

    def i18n_t(key)
      I18n.t(key, scope: 'users.controllers')
    end
end