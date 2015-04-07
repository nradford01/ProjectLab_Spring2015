class UsersController < ApplicationController
	before_action :authenticate_user!
  
  def profile
    @user = current_user
    @assigned_tasks = Task.where(assigned_user_id: current_user)
    @project = Project.find_by(params[:project_id])
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

end
