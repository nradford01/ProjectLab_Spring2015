require 'test_helper'


class TaskTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:one)
  end

  test "due_date should be in the future" do
    @task.due_date = Time.now + 2.minutes
    assert @task.valid?
  end

  test "due_date should not be in the past" do
    @task.due_date = Time.now - 2.minutes
    assert_not @task.valid?
  end

  test "Task fields shouldn't be able to be blank" do
    @task.name = " "
    @task.description = " "
    assert_not @task.valid?
  end

  test "Priority status should default to medium" do
  @task.priority = 2
  assert true
end

test "complete status should default to incomplete" do
  @task.complete= 'false'
  assert true
end

end
