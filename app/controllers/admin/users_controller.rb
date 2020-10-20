class Admin::UsersController < ApplicationController
  before_action :set_user,only: [:show,:edit,:update,:destroy]
  before_action :admin_user

  PER = 10
  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(PER)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザーを登録しました'
      redirect_to admin_users_path: "ユーザーd「#{@user}」を登録しました。"
    else
      render :new
    end
  end

  def show
    @tasks =  @user.tasks.page(params[:page]).per(PER).order('updated_at DESC')
    #@tasks = Task.all.includes(:user)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path(@user),
      notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path,
    notice: "ユーザー「#{@user.name}を削除しました。」"
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user
      if !current_user.admin?
      flash[:notice] =  '管理者以外はアクセスできません'
      redirect_to root_url
    end
  end
end
