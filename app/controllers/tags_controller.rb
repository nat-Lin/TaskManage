class TagsController < ApplicationController
  before_action :find_tag, only: [:update, :destroy]
  
  def index
    @tag = Tag.new
    @tags = current_user.tags
  end

  def create
    @tag = current_user.tags.new(tag_params)
    successful_and_failed_flash(@tag.save, '新增')
    redirect_to tags_path
  end

  def update
    successful_and_failed_flash(@tag.update(tag_params), '更新')
    redirect_to tags_path
  end

  def destroy
    successful_and_failed_flash(@tag.destroy, '刪除')
    redirect_to tags_path
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end

    def successful_and_failed_flash(action, action_name)
      action ? flash[:notice] = "#{action_name}成功" : flash[:error] = "#{action_name}失敗"
    end

    def find_tag
      @tag = Tag.find_by_id(params[:id])
    end
end