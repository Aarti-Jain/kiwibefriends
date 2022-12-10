require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @restaurant  = restaurants(:one)
    @admin_user  = users(:michael)
    @normal_user = users(:archer)
  end

  test "normal user should not get new restaurant" do
    log_in_as(@normal_user)
    get restaurants_new_url
    assert_equal "Users cannot edit Restaurants", flash[:danger]
    assert_redirected_to root_url
  end

  test "admin user should get new restaurant" do
    log_in_as(@admin_user)
    get restaurants_new_url
    assert_template 'restaurants/new'
  end

  test "should redirect destroy restaurant when logged in as a non-admin" do
    log_in_as(@normal_user)
    assert_no_difference 'Restaurant.count' do
      delete restaurant_path(@restaurant)
    end
    assert_redirected_to root_url
  end

  test "should redirect restaurant followers when not logged in" do
    get restaurant_followers_restaurant_path(@restaurant)
    assert_redirected_to login_url
  end

  test "non logged in user should not get leaderboard" do
    get leaderboard_path
    assert_redirected_to login_url
  end

  test "logged in user should get leaderboard" do
    log_in_as(@normal_user)
    get leaderboard_path
    assert_template 'restaurants/leaderboard'
  end
end
