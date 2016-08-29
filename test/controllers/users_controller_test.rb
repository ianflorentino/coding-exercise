require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url, as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token } 
    assert_response :success
  end

  test "should show user" do
    get user_url(@user), as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token }
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: {name: 'Baz Foo'}, as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token }
    @user.reload
    assert @user.name != 'MyString'
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json, headers: { 'HTTP_AUTHORIZATION' => @user.prynt_auth_token }
    end

    assert_response 204
  end
end
