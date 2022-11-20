require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    login_as @user
  end

  test "should get new" do
    new_user = User.new handle: 'new_user'
    login_as new_user

    get new_user_url
    assert_response :success
  end

  test "should create user" do
    new_user = User.new handle: 'new_user'
    login_as new_user

    assert_difference("User.count") do
      post users_url, params: { user: { handle: 'new_user' } }
    end

    assert_redirected_to posts_url
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { handle: @user.handle } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to root_url
  end
end
