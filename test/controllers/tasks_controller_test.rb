require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
    @user = users(:one)
    @user2 = users(:two)
  end

  test "should get index" do
    get tasks_url, as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token }
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post tasks_url, params: { title: 'foo', description: 'bar', user_id: @user.id }, as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token }
    end

    assert_response 201
  end

  test "should assign a task to a new user" do
    assert_difference('@task.users.count') do
      post assign_url(@task), params: {user_id: @user2.id}, as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token }
    end

    assert_response :success
  end

  test "should unassign a task to a current user" do
    @task.users << @user2
    @task.save

    assert_difference('@task.users.count', -1) do
      post unassign_url(@task), params: {user_id: @user2.id}, as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token }
    end

    assert_response :success
  end

  test "should show task" do
    get task_url(@task), as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token }
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: {  } }, as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token }
    assert_response 200
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task), as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token }
    end

    assert_response 204
  end
end
