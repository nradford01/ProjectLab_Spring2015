require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:one)
    @other_user = users(:two)
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
    sign_in @user
    current_user = @user
    post :create, project_id: @project.id, task: { :name => 'Test', :description => 'Test description' , 
                                                   :due_date => (Time.current + 1.minutes), :user_id => @user.id}
    task = assigns(:task)
    assert_equal current_user.id, task.user_id
  end

  test "Can assign a task to another user" do
    sign_in @user
    current_user = @user
    post :create, project_id: @project.id, task: { :name => 'Test', :description => 'Test description', :assigned_user_id => @other_user.id,
                                                   :due_date => (Time.current + 1.minutes), :user_id => current_user.id}
    task = assigns(:task)
    assert_not_equal @user.id, task.assignee.id
    assert_equal @other_user.id, task.assignee.id 
  end   

  test "Can assign a task to the current user" do
    sign_in @user
    current_user = @user
    post :create, project_id: @project.id, task: { :name => 'Test', :description => 'Test description', :assigned_user_id => current_user.id,
                                                   :due_date => (Time.current + 1.minutes), :user_id => current_user.id}
    task = assigns(:task)
    assert_equal @user.id, task.assignee.id
    assert_not_equal @other_user.id, task.assignee.id 
  end                            

  test "Priority Should be medium" do
    post :create,project_id: @project.id, id: @task.id, task: { :name => 'Test', 
                                                                :description => 'Testing, Testing.', 
                                                                :due_date => (Time.current + 1.minutes) }
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

end
