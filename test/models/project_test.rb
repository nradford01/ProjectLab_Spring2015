require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @project = projects(:one)
  end

  test "due_date should be in the future" do
  	@project.due_date = Time.now + 2.minutes
  	assert @project.valid?
  end

  test "due_date should not be in the past" do
    @project.due_date = Time.now - 2.minutes
    assert_not @project.valid?
  end

	test "name should be present " do
    @project.name = " "
    assert @project.invalid?
  end

  test "description should be present " do
    @project.description = " "
    assert_not @project.valid?
  end
end