require 'test_helper'

class DemoAsControllerTest < ActionController::TestCase
  setup do
    @demo_a = demo_as(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:demo_as)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create demo_a" do
    assert_difference('DemoA.count') do
      post :create, demo_a: {  }
    end

    assert_redirected_to demo_a_path(assigns(:demo_a))
  end

  test "should show demo_a" do
    get :show, id: @demo_a
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @demo_a
    assert_response :success
  end

  test "should update demo_a" do
    patch :update, id: @demo_a, demo_a: {  }
    assert_redirected_to demo_a_path(assigns(:demo_a))
  end

  test "should destroy demo_a" do
    assert_difference('DemoA.count', -1) do
      delete :destroy, id: @demo_a
    end

    assert_redirected_to demo_as_path
  end
end
