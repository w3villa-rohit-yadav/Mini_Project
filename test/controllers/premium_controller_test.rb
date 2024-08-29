require "test_helper"

class PremiumControllerTest < ActionDispatch::IntegrationTest
  test "should get buy" do
    get premium_buy_url
    assert_response :success
  end
end
