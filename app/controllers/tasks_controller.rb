class TasksController < ApplicationController
  before_action :find_task, only:[:destroy, :update, :show, :edit]

  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new(task_params)
    
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
      params.require(:task).permit(:title, :notes,:end_time,:start_time)
    end

    def find_task
      @task = Task.find_by(id: params[:id])
    end

    def i18n_t key
      I18n.t("tasks.controller#{key}")
    end
end