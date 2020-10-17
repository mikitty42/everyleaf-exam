class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:notice] = 'ログインが必要です'
      redirect_to new_session_path
    end
  end
end
