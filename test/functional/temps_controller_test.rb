require 'test_helper'

class TempsControllerTest < ActionController::TestCase
  setup do
    @temp = temps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:temps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create temp" do
    assert_difference('Temp.count') do
      post :create, :temp => @temp.attributes
    end

    assert_redirected_to temp_path(assigns(:temp))
  end

  test "should show temp" do
    get :show, :id => @temp.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @temp.to_param
    assert_response :success
  end

  test "should update temp" do
    put :update, :id => @temp.to_param, :temp => @temp.attributes
    assert_redirected_to temp_path(assigns(:temp))
  end

  test "should destroy temp" do
    assert_difference('Temp.count', -1) do
      delete :destroy, :id => @temp.to_param
    end

    assert_redirected_to temps_path
  end
end
