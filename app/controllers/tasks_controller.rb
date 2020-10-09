class TasksController < ApplicationController
  before_action :set_task,only: [:show,:edit,:update,:destroy]
PER = 10
  def index
    @task_search_params = task_search_params
    @tasks =Task.all
    @tasks = @tasks.search(@task_search_params)
    if params[:sort_expired]
      @tasks = @tasks.order(limit_date: :desc)
    elsif params[:priority_expired]
      @tasks = @tasks.order(priority: :asc)
    else
      @tasks = @tasks.order(created_at: :desc)
    end

    @tasks = @tasks.page(params[:page]).per(PER)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = 'タスクを登録しました'
      redirect_to task_path(@task.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path,notice: 'タスクを編集しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path,notice: 'タスクを削除しました'
  end

  private

  def task_params
    params.require(:task).permit(:title,:content,:limit_date,:status,:priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_search_params
    params.fetch(:search, {}).permit(:title, :content, :status, :priority, :limit_date)
  end
end
