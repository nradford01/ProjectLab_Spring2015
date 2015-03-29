require 'test_helper'

class TasksControllerTest < ActionController::TestCase

def setup
    @project = projects(:one)
    @other_project = projects(:two)
    @task = tasks(:one)
    @other_task = tasks(:two)
    @new_params = { name: "Updated", description: "This is updated"}
  end

  test "Tasks should belong to project when created/update" do
   post :create, project_id: @project.id, task: { :name => 'Test', 
                                                  :description => 'Test description',
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

end
