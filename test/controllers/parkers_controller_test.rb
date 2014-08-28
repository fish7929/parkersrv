require 'test_helper'

class ParkersControllerTest < ActionController::TestCase
  setup do
    @parker = parkers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parkers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parker" do
    assert_difference('Parker.count') do
      post :create, parker: { address: @parker.address, garage_name: @parker.garage_name, isOpen: @parker.isOpen, point: @parker.point, price: @parker.price, remaining_parking_spaces: @parker.remaining_parking_spaces, road_garage: @parker.road_garage, status: @parker.status, total_parking_spaces: @parker.total_parking_spaces }
    end

    assert_redirected_to parker_path(assigns(:parker))
  end

  test "should show parker" do
    get :show, id: @parker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parker
    assert_response :success
  end

  test "should update parker" do
    patch :update, id: @parker, parker: { address: @parker.address, garage_name: @parker.garage_name, isOpen: @parker.isOpen, point: @parker.point, price: @parker.price, remaining_parking_spaces: @parker.remaining_parking_spaces, road_garage: @parker.road_garage, status: @parker.status, total_parking_spaces: @parker.total_parking_spaces }
    assert_redirected_to parker_path(assigns(:parker))
  end

  test "should destroy parker" do
    assert_difference('Parker.count', -1) do
      delete :destroy, id: @parker
    end

    assert_redirected_to parkers_path
  end
end
