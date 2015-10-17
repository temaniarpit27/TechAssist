require 'test_helper'

class TagUsersControllerTest < ActionController::TestCase
  setup do
    @tag_user = tag_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tag_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tag_user" do
    assert_difference('TagUser.count') do
      post :create, tag_user: { question_id: @tag_user.question_id, user_id: @tag_user.user_id }
    end

    assert_redirected_to tag_user_path(assigns(:tag_user))
  end

  test "should show tag_user" do
    get :show, id: @tag_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tag_user
    assert_response :success
  end

  test "should update tag_user" do
    patch :update, id: @tag_user, tag_user: { question_id: @tag_user.question_id, user_id: @tag_user.user_id }
    assert_redirected_to tag_user_path(assigns(:tag_user))
  end

  test "should destroy tag_user" do
    assert_difference('TagUser.count', -1) do
      delete :destroy, id: @tag_user
    end

    assert_redirected_to tag_users_path
  end
end
