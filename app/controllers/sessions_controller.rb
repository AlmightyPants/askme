class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[destroy]

  def new
  end

  def create 
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sign_in user
      flash[:success] = "Welcome back, #{user.name}!"
      redirect_to root_path
    else
      flash[:warning] = "Incorrect!"
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Good bye!"
    redirect_to root_path
  end
end