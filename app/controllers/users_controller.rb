class UsersController < ApplicationController
  before_action :login_prohibited,only: [:new,:create]
  before_action :correct_user,only:[:show]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

    private

    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

    def login_prohibited
     !logged_in? || redirect_to(root_path)
     flash[:notice] = '権限がありません'
    end
  end
