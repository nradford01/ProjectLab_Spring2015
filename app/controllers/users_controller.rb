class UsersController < ApplicationController
	before_action :authenticate_user!
  
  def profile
    @user = current_user
  end

  def show
    @user = user.find(params[:id])
  end

  def index
    @users = User.all
  end

end
