class TasksController < ApplicationController
  before_action :find_task, only:[:destroy, :update, :show, :edit]

  def index
    @tasks = search_tasks
  end

  def create
    @task = current_user.tasks.new(task_params)
    
    if @task.save
      flash[:notice] = i18n_t('.create_successful')
      redirect_to @task
    else
      render :new
    end
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def show
  end

  def update
    if @task.update(task_params)
      flash[:notice] = i18n_t('.update_successful')
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: i18n_t('.destroy_successful')
  end

  private
    def task_params
      params.require(:task).permit(:title, :notes, :end_time, :start_time, :status, :priority)
    end

    def find_task
      @task = current_user.tasks.find_by_id(params[:id])
    end

    def i18n_t(key)
      I18n.t("#{key}", scope: 'tasks.controller')
    end

    def search_params
      params.require(:search).permit(:statuses, :sort, :title)
    end

    def search_tasks
      task = current_user.tasks.page(params[:page])
      return task if params[:search].nil?
      [
        {key: search_params[:statuses], scope: :search_status},
        {key: search_params[:title], scope: :search_title},
        {key: search_params[:sort], scope: :field_sort}
      ].each do |val|
        next if val[:key].blank?
        task = task.try(val[:scope], val[:key])
      end
      task
    end
end