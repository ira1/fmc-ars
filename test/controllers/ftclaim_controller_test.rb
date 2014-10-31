require 'test_helper'

class FtclaimControllerTest < ActionController::TestCase
  test "should get Output" do
    get :Output
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
