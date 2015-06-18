class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up!"
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(params[:id])
  end

  def update
    @user = User.find_by(params[:id])
    if @user.save
      redirect_to @user, notice: "T"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by(params[:id])
    @user.destroy
    redirect_to root_url, alert: "Account successfully deleted."
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end
end
