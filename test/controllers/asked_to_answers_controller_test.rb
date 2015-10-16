require 'test_helper'

class AskedToAnswersControllerTest < ActionController::TestCase
  setup do
    @asked_to_answer = asked_to_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asked_to_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asked_to_answer" do
    assert_difference('AskedToAnswer.count') do
      post :create, asked_to_answer: { question_id: @asked_to_answer.question_id, user_id: @asked_to_answer.user_id }
    end

    assert_redirected_to asked_to_answer_path(assigns(:asked_to_answer))
  end

  test "should show asked_to_answer" do
    get :show, id: @asked_to_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asked_to_answer
    assert_response :success
  end

  test "should update asked_to_answer" do
    patch :update, id: @asked_to_answer, asked_to_answer: { question_id: @asked_to_answer.question_id, user_id: @asked_to_answer.user_id }
    assert_redirected_to asked_to_answer_path(assigns(:asked_to_answer))
  end

  test "should destroy asked_to_answer" do
    assert_difference('AskedToAnswer.count', -1) do
      delete :destroy, id: @asked_to_answer
    end

    assert_redirected_to asked_to_answers_path
  end
end
