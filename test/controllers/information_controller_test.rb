require 'test_helper'

class InformationControllerTest < ActionController::TestCase
  setup do
    @information = information(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:information)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create information" do
    assert_difference('Information.count') do
      post :create, information: { garage_name: @information.garage_name, latitude: @information.latitude, longitude: @information.longitude, position: @information.position, total_parking_space: @information.total_parking_space, uuid: @information.uuid }
    end

    assert_redirected_to information_path(assigns(:information))
  end

  test "should show information" do
    get :show, id: @information
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @information
    assert_response :success
  end

  test "should update information" do
    patch :update, id: @information, information: { garage_name: @information.garage_name, latitude: @information.latitude, longitude: @information.longitude, position: @information.position, total_parking_space: @information.total_parking_space, uuid: @information.uuid }
    assert_redirected_to information_path(assigns(:information))
  end

  test "should destroy information" do
    assert_difference('Information.count', -1) do
      delete :destroy, id: @information
    end

    assert_redirected_to information_index_path
  end
end
