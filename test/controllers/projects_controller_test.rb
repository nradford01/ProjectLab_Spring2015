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
		assert_difference('Project.count', -1) do
			delete :destroy, id: @project.id
		end
		assert_redirected_to projects_path
	end

	test "test should edit" do
		get :edit, id: @project.id
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

  test "Editing a project should not assign it to another user" do
  	post :create, project: { :name => 'Test', :description => 'Test description' , :due_date => (Time.current + 1.minutes), 
  													 :user_id => @user.id }
  	project = assigns(:project)
  	sign_out @user
  	sign_in @other_user
		get :edit, id: project.id
		assert_template :edit
		patch :update, id: project.id, project: @new_params
		project = assigns(:project)
		assert_equal @user.id, project.user_id
		assert_not_equal @other_user, project.user_id
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
  	assert_redirected_to projects_path
	end
end
