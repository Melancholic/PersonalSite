require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get rootpage" do
    get :rootpage
    assert_response :success
  end

end
