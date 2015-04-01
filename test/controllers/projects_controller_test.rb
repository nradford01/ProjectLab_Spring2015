require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
	def setup
		@user = users(:one)
    @other_user = users(:two)
		@project = projects(:one)
		@other_project = projects(:two)
		@new_params = { name: "Updated", description: "This is updated"}
		sign_in @user
	end

	test "should create project" do
		assert_difference('Project.count', 1) do
			post :create, project: { :name => 'Test', :description => 'Test description' , :due_date => (Time.current + 1.minutes), 
															 :user_id => 1}	
		end
		assert_redirected_to projects_path
	end

	test "should delete project" do
		post :create, project: { :name => 'Test', :description => 'Test description' , :due_date => (Time.current + 1.minutes), 
														 :user_id => @user.id }
		project = assigns(:project)
		assert_difference('Project.count', -1) do
			delete :destroy, id: project.id
		end
		assert_redirected_to projects_path
	end

	test "test should edit" do
		post :create, project: { :name => 'Test', :description => 'Test description' , :due_date => (Time.current + 1.minutes), 
														 :user_id => @user.id }
		project = assigns(:project)
		get :edit, id: project.id
		assert_response :success
		assert_template :edit
	end

	test 'test should update' do
		patch :update, id: @project.id, project: @new_params
		project = assigns(:project)
		assert_equal project.name, @new_params[:name]
	end

	test "Creating a project should assign it to the current user" do
    current_user = @user
		post :create, project: { :name => 'Test', :description => 'Test description' , :due_date => (Time.current + 1.minutes), 
														 :user_id => current_user.id }
		project = assigns(:project)
		assert_equal current_user.id, project.user.id
  end

  test "Project can only be edited by the creator" do
		post :create, project: { :name => 'Test', :description => 'Test description' , :due_date => (Time.current + 1.minutes), 
  													 :user_id => @user.id }
  	project = assigns(:project)
  	get :edit, id: project.id
  	assert_response :success
		assert_template :edit
		sign_out @user
		sign_in @other_user
		get :edit, id: project.id
		patch :update, id: @project.id, project: @new_params
		updated_project = assigns(:project)
		assert_not_equal updated_project.name, @new_params[:name]
  	assert_redirected_to projects_path
	end

	test "Priority Should be medium" do
		post :create, id: @project.id, project: { :name => 'Test', 
																				 :description => 'Testing, Testing.', 
																				 :due_date => (Time.current + 1.minutes) }
		project = assigns(:project)
		assert_equal project.priority, "medium"
	end	

	test "completed should be false" do 
		post :create, id: @project.id, project: { :name => 'Test',
																							:description => 'Testing, again.',
																							:due_date => (Time.current + 1.minutes) }
		project = assigns(:project)
		assert_equal project.complete, false																					
	
	end
end
