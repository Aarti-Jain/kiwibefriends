require "test_helper"

class RestaurantsProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @admin_user = users(:archer)
    @restaurant = restaurants(:two)
    # @admin_user.microposts.create!(content:'one',restaurant_id:@restaurant.id)
    # @admin_user.microposts.create!(content:'two',restaurant_id:@restaurant.id)
    # @admin_user.microposts.create!(content:'three',restaurant_id:@restaurant.id)
  end

  test "restaurant profile display" do
    log_in_as(@admin_user)
    get restaurant_path(@restaurant)
    assert_template 'restaurants/show'
    assert_select 'title', full_title(@restaurant.name)
    assert_select 'h1', text: @restaurant.name
    assert_select 'h1>img.gravatar'
    assert_match @restaurant.microposts.count.to_s, response.body
    # assert_select 'div.pagination'
    @restaurant.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end
