class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :user_signed_in?, except: [:index]
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
  end

  def update
    if @project.update(project_params)
      flash[:success] = "Updated the project: '#{@project.name}'"
      redirect_to projects_path
    else
      flash[:danger] = "Please fill in every field and ensure the due date is in the future."
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:success] = "Destroyed the project named: '#{@project.name}'"
    redirect_to projects_path
  end

  private
  
    def project_params
      params.require(:project).permit(:name, :description, :due_date)
    end

    def set_project
      @project = Project.find(params[:id])
    end
end
