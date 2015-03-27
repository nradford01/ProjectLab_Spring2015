require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @other_user = users(:two)
  end

  test "should get profile" do
    get :profile
    assert_redirected_to new_user_session_path
    sign_in :user, @user
    get :profile
    assert_response :success
  end

  test "should get show" do
    sign_in @user
    user = @other_user
    get :show, id: user.id
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_redirected_to new_user_session_path
    sign_in :user, @user
    get :index
    assert_response :success
  end
end
