class SessionsController < ApplicationController
  def new

  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      flash.now[:notice] = "Welcome back, #{user.name}!"
      redirect_to user
    else
      flash.now[:alert] = "Couldn't find an account with that email/password combination."
      render :new
    end
  end
end
