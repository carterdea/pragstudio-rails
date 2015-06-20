class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  # before_action :require_admin, only: [:destroy]

  def index
    @users = User.not_admin
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thank you for signing up!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Successfully updated your account."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, alert: "Account successfully deleted. We're sorry to see you go! 😢"
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to root_path, notice: "Sorry, you can't do that."
    end
  end
end
