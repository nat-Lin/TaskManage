class Admin::UsersController < ApplicationController

  def index
    @users = User.includes('tasks').page(params[:page])
  end

  def show
    @user = User.find_by_id(params[:id])
    @tasks = @user.tasks.page(params[:page])
  end
end