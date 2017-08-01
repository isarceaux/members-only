class SessionsController < ApplicationController
  
  def new

  end

  def create
    #Find user
    user = User.find_by(email:params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      #if remember me is coché launch remember otherwise launch forget
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to current_user
    else
      flash.now[:danger] = "Invalid username / password"
      render :new
    end

  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

end
