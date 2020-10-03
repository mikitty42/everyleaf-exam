class TasksController < ApplicationController
  before_action :set_task,only: [:show,:edit,:update,:destroy]

  def index
    if params[:title].present? && params[:status].present?
      @tasks = Task.get_by_status_title(params[:title],params[:status]).page(params[:page]).per(10)
    elsif params[:title].present?
        @tasks = Task.get_by_title(params[:title]).page(params[:page]).per(10)
    elsif params[:status].present?
        @tasks = Task.get_by_status(params[:status]).page(params[:page]).per(10)
      else
        if params[:sort_expired]
          @tasks = Task.order(limit_date: :desc).page(params[:page]).per(10)
        elsif params[:priority_expired]
          @tasks = Task.order(priority: :asc).page(params[:page]).per(10)
        else
          @tasks = Task.order(created_at: :desc).page(params[:page]).per(10)
        end
      end
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
end
