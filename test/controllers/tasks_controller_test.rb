require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @third_user = users(:three)
    @project = projects(:one)
    @other_project = projects(:two)
    @task = tasks(:one)
    @other_task = tasks(:two)
    @new_params = { name: "Updated", description: "This is updated"}
    sign_in @user
  end

  test "Tasks should belong to project when created/update" do
    post :create, project_id: @project.id, task: { :name => 'Test', :description => 'Test description' , 
                                                   :due_date => (Time.current + 1.minutes) }
    task = assigns(:task)
    assert_equal @project.id, task.project_id
  end

  test "Deleting a project should delete all of its tasks" do
   post :create, project_id: @project.id, task: { :name => 'Test', 
                                                  :description => 'Test description',
                                                  :due_date => (Time.current + 1.minutes) }
    task = assigns(:task)
    assert_difference('Task.count', -@project.tasks.count) do
      @project.destroy
    end
  end

  test "Creating a task should assign it to a user" do
    current_user = @user
    post :create, project_id: @project.id, task: { :name => 'Test', :description => 'Test description' , 
                                                   :due_date => (Time.current + 1.minutes), :user_id => @user.id}
    task = assigns(:task)
    assert_equal current_user.id, task.user_id
  end

  test "Can assign a task to another user" do
    current_user = @user
    post :create, project_id: @project.id, task: { :name => 'Test', :description => 'Test description', :assigned_user_id => @other_user.id,
                                                   :due_date => (Time.current + 1.minutes), :user_id => current_user.id}
    task = assigns(:task)
    assert_not_equal @user.id, task.assignee.id
    assert_equal @other_user.id, task.assignee.id 
  end   

  test "Can assign a task to the current user" do
    current_user = @user
    post :create, project_id: @project.id, task: { :name => 'Test', :description => 'Test description', :assigned_user_id => current_user.id,
                                                   :due_date => (Time.current + 1.minutes), :user_id => current_user.id}
    task = assigns(:task)
    assert_equal @user.id, task.assignee.id
    assert_not_equal @other_user.id, task.assignee.id 
  end                            

  test "Priority Should be medium" do
    post :create, project_id: @project.id, id: @task.id, task: { :name => 'Test', 
                                                                :description => 'Testing, Testing.', 
                                                                :due_date => (Time.current + 1.minutes),
                                                                :user_id => @user.id }
    task = assigns(:task)
    assert_equal task.priority, "medium"
  end 

  test "completed should be false" do 
    post :create, project_id: @project.id, id: @task.id, task: { :name => 'Test',
                                                                :description => 'Testing, again.',
                                                                :due_date => (Time.current + 1.minutes) }
    task = assigns(:task)   
    assert_equal task.complete, false
  end

  test "Only task creator and assignee can edit a task" do
    post :create, project_id: @project.id, task: { :name => 'Test', :description => 'Test description', :assigned_user_id => @other_user.id,
                                                   :due_date => (Time.current + 1.minutes), :user_id => @user.id}
    task = assigns(:task)
    get :edit, project_id: @project.id, id: task.id
    assert_response :success
    assert_template :edit
    sign_out @user
    sign_in @other_user
    get :edit, project_id: @project.id, id: task.id
    assert_response :success
    assert_template :edit 
    sign_out @user
    sign_in @third_user
    get :edit, project_id: @project.id,id: task.id
    patch :update, project_id: @project.id, id: task.id, task: @new_params
    updated_task = assigns(:task)
    assert_not_equal updated_task.name, @new_params[:name]
    assert_redirected_to @project
  end

  test "Task can not be deleted by other user" do
    post :create, project_id: @project.id, task: { :name => 'Test', :description => 'Test description', :assigned_user_id => @other_user.id,
                                                   :due_date => (Time.current + 1.minutes), :user_id => @user.id}
    task = assigns(:task)
    sign_out @user
    sign_in @third_user
    assert_no_difference('Task.count') do
      get :destroy, project_id: @project.id, id: task.id
    end
    assert_redirected_to @project
  end
end
