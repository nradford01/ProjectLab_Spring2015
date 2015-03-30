class TasksController < ApplicationController
  before_action :set_project

  def new
    @task = @project.tasks.build
    @priorities = Task.priorities

  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = @project.tasks.build(task_params)
    if @task.save
      flash[:success] = "Task Created"
      redirect_to @project
    else
      flash[:danger] = "Please fill in every field and ensure the due date is in the future."
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "Updated the task: '#{@task.name}'"
      redirect_to @project
    else
      flash[:danger] = "Please fill in every field and ensure the due date is in the future."
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "Deleted the task named: '#{@task.name}'"
    redirect_to @project
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :project_id)
  end
end
    
