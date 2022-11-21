require "test_helper"

class RestaurantsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @restaurant = restaurants(:one)
    @admin_user = users(:michael)
  end

  test "restaurant index including pagination" do
    log_in_as(@admin_user)
    get restaurants_path
    assert_template 'restaurants/index'
    assert_select 'div.pagination'
    Restaurant.paginate(page: 1).each do |restaurant|
      assert_select 'a[href=?]', restaurant_path(restaurant), text: restaurant.name
    end
  end
end
