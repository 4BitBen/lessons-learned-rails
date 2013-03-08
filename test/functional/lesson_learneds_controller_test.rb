require 'test_helper'

class LessonLearnedsControllerTest < ActionController::TestCase
  setup do
    @lesson_learned = lesson_learneds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lesson_learneds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lesson_learned" do
    assert_difference('LessonLearned.count') do
      post :create, lesson_learned: @lesson_learned.attributes
    end

    assert_redirected_to lesson_learned_path(assigns(:lesson_learned))
  end

  test "should show lesson_learned" do
    get :show, id: @lesson_learned
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lesson_learned
    assert_response :success
  end

  test "should update lesson_learned" do
    put :update, id: @lesson_learned, lesson_learned: @lesson_learned.attributes
    assert_redirected_to lesson_learned_path(assigns(:lesson_learned))
  end

  test "should destroy lesson_learned" do
    assert_difference('LessonLearned.count', -1) do
      delete :destroy, id: @lesson_learned
    end

    assert_redirected_to lesson_learneds_path
  end
end
