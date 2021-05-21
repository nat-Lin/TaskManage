class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :find_user, only: [:update, :destroy]
  before_action :verify_user_admin, only: [:update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = '註冊成功'
      redirect_to current_user.try('admin?') ? admin_root_path : new_session_path
    else
      render :new
    end
  end

  def update
    update_params = params.require(:user).permit(:role)
    if @user.update(update_params)
      flash[:notice] = '更新成功'
      redirect_to admin_root_path
    else
      flash[:error] = '更新失敗'
      redirect_to admin_root_path
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = '刪除成功'
    redirect_to admin_root_path
  end
  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    def find_user
      @user = User.find_by_id(params[:id])
    end

    def verify_user_admin
      if !current_user.admin?
        flash[:error] = '權限不足，無法進行操作'
        redirect_to root_path 
      elsif current_user == @user
        flash[:error] = '無法操作本帳號'
        redirect_to admin_root_path
      end
    end
end