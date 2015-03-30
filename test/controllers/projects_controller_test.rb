require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
	def setup
		@user = users(:one)
    @other_user = users(:two)
		@project = projects(:one)
		@other_project = projects(:two)
		@new_params = { name: "Updated", description: "This is updated"}
	end

	test "should create project" do
		sign_in @user
		assert_difference('Project.count', 1) do
			post :create, project: { :name => 'Test', :description => 'Test description' , :due_date => (Time.current + 1.minutes)}	
		end
		assert_redirected_to projects_path
	end

	test "should delete project" do
		sign_in @user
		assert_difference('Project.count', -1) do
			delete :destroy, id: @project.id
		end
		assert_redirected_to projects_path
	end

	test "test should edit" do
		sign_in @user
		get :edit, id: @project.id
		assert_response :success
		assert_template :edit
	end

	test 'test should update' do
		sign_in @user 
		patch :update, id: @project.id, project: @new_params
		project = assigns(:project)
		assert_equal project.name, @new_params[:name]
	end
end
