class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def show

  end

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Project Created"
      redirect_to projects_path
    else
      flash[:danger] = "Please fill in every field and ensure the due date is in the future."
      render :new
    end
  end

  def edit
    if current_user.id != project.user_id
      flash[:danger] = "You are not authorized to edit this project."
      redirect to @projects
    end
  end

  def update
    @priority = Project.priorities
    if @project.update(project_params)
      flash[:success] = "Updated the project: '#{@project.name}'"
      redirect_to projects_path
    else
      flash[:danger] = "Please fill in every field and ensure the due date is in the future."
      render :edit
    end
  end

  def destroy
    if current_user.id == project.user_id
      @project.destroy
      flash[:success] = "Destroyed the project named: '#{@project.name}'"
      redirect_to projects_path
    else
      flash[:danger] = "You are not authorized to delete this project."
      redirect_to @project
    end
  end

  private
  
    def project_params
      params.require(:project).permit(:name, :description, :due_date, :complete, :priority, :user_id)
    end

    def set_project
      @project = Project.find(params[:id])
    end

end
