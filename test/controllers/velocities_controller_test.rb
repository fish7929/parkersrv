require 'test_helper'

class VelocitiesControllerTest < ActionController::TestCase
  setup do
    @velocity = velocities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:velocities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create velocity" do
    assert_difference('Velocity.count') do
      post :create, velocity: { garage_num: @velocity.garage_num, t_10am: @velocity.t_10am, t_10pm_8am: @velocity.t_10pm_8am, t_11am: @velocity.t_11am, t_12pm: @velocity.t_12pm, t_1pm: @velocity.t_1pm, t_2pm: @velocity.t_2pm, t_3pm: @velocity.t_3pm, t_4pm: @velocity.t_4pm, t_5pm: @velocity.t_5pm, t_6pm: @velocity.t_6pm, t_7pm: @velocity.t_7pm, t_8am: @velocity.t_8am, t_8pm: @velocity.t_8pm, t_9am: @velocity.t_9am, t_9pm: @velocity.t_9pm, uuid: @velocity.uuid }
    end

    assert_redirected_to velocity_path(assigns(:velocity))
  end

  test "should show velocity" do
    get :show, id: @velocity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @velocity
    assert_response :success
  end

  test "should update velocity" do
    patch :update, id: @velocity, velocity: { garage_num: @velocity.garage_num, t_10am: @velocity.t_10am, t_10pm_8am: @velocity.t_10pm_8am, t_11am: @velocity.t_11am, t_12pm: @velocity.t_12pm, t_1pm: @velocity.t_1pm, t_2pm: @velocity.t_2pm, t_3pm: @velocity.t_3pm, t_4pm: @velocity.t_4pm, t_5pm: @velocity.t_5pm, t_6pm: @velocity.t_6pm, t_7pm: @velocity.t_7pm, t_8am: @velocity.t_8am, t_8pm: @velocity.t_8pm, t_9am: @velocity.t_9am, t_9pm: @velocity.t_9pm, uuid: @velocity.uuid }
    assert_redirected_to velocity_path(assigns(:velocity))
  end

  test "should destroy velocity" do
    assert_difference('Velocity.count', -1) do
      delete :destroy, id: @velocity
    end

    assert_redirected_to velocities_path
  end
end
