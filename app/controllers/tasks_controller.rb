class TasksController < ApplicationController
  before_action :set_task,only: [:show,:edit,:update,:destroy]
  before_action :logged_in_user, only:[:index]
  before_action :authenticate_user,only: [:index]

PER = 10
  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.order(limit_date: :desc).page(params[:page]).per(PER)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :asc).page(params[:page]).per(PER)
    elsif
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(PER)
    end

    if params[:search].present?
      if params[:title].present? && params[:status].present?
        @tasks = current_user.tasks.get_by_title(params[:title]).get_by_status(params[:status]).page(params[:page]).per(PER)
      elsif params[:title].present?
          @tasks = current_user.tasks.get_by_title(params[:title]).page(params[:page]).per(PER)
      elsif params[:status].present?
          @tasks = current_user.tasks.get_by_status(params[:status]).page(params[:page]).per(PER)
      end
    end
  end


  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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

  def authenticate_user
    if @current_user == nil
      flash[:notice] = 'ログインが必要です'
      redirect_to new_session_path
    end
  end
end
