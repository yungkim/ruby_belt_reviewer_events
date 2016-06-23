class UsersController < ApplicationController
  before_action :require_login, except: [:index, :create, :login]
  def index
    @user = User.new #  for "<%= form_for @user, :url => { :action => "create" } do |f| %>"
  end
  def show
      @user = User.find_by_id(session[:user_id])
      @users = User.all
  end
  def create
    user = User.new(users_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/events'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/'
    end
  end
  def login
    user = User.find_by_email(users_params[:email])
    if user && user.authenticate(users_params[:password])
      session[:user_id] = user.id
      redirect_to '/events'
    else
      flash[:errors] = ["Invalid combination"]
      redirect_to '/'
    end
  end
  def logout
      session[:user_id] = nil # or use 'session.clear'
      redirect_to '/'
  end
  def update
    @user = User.find_by_id(session[:user_id])
    if @user.update(users_params)
      flash[:notice] = "Your profile has been updated successfully!"
    else
      flash[:errors] = @user.errors.full_messages
    end
  redirect_to "/users/#{@user.id}"
  end

  private
  def users_params
      params.require(:user).permit(:first_name, :last_name, :email, :location, :password, :password_confirmation, :state)
  end
end
