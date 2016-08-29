require 'test_helper'
# using ostruct to mimic dot notation of OAuth Hash Obj
require 'ostruct'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should generate auth token" do
    @user.generate_auth_token
    assert @user.prynt_auth_token != 'MyString'
  end

  test "should create user from oauth object" do
    assert_difference('User.count') do
      auth_object = OpenStruct.new({
        uid: "10104414099326421", 
        provider: "facebook",
        info: OpenStruct.new({
          name: "Foo Bar"
        }),
        credentials: OpenStruct.new({
          token: "EAACjYul4uX8BAOEX01YkE0kRkETAmEDyL9wzRj8IUhTvZBTKR…GJ4jOqyXKrDQoNxvBG85vAVcZC1yAE6MZCZBu0DSrTOeAZDZD", 
          expires_at: 3902
        })
      }) 

      User.find_or_create_from_oauth(auth_object)
    end
  end

  test "should return existing user" do
    auth_object = OpenStruct.new({
      uid: "MyString", 
      provider: "MyString",
      info: OpenStruct.new({
        name: "MyString"
      }),
      credentials: OpenStruct.new({
        token: "MyString", 
        expires_at: 3902 
      })
    }) 

    @user.save
    user = User.find_or_create_from_oauth(auth_object)
    assert @user.id == user.id
   end
end
