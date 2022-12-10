require "test_helper"

class RestaurantsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @restaurant = restaurants(:one)
    @admin_user = users(:michael)
  end

  test "restaurant index" do
    log_in_as(@admin_user)
    get restaurants_path, params: { query: "re" }
    assert_template 'restaurants/index'
  end
end
