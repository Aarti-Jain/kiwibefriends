require "test_helper"

class FollowingRestaurantTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = users(:user_1)
    @user2 = users(:user_2)
    @restaurant1 = restaurants(:one)
    @restaurant2 = restaurants(:two)
    @user1.restaurant_follow(@restaurant1)
    log_in_as(@user1)
  end
end

class FollowersRestaurantPageTest < FollowingRestaurantTest

  test "restaurants followers page" do
    get restaurant_followers_restaurant_path(@restaurant1)
    assert_response :unprocessable_entity
    assert_not @restaurant1.restaurant_followers.empty?
    assert_match @restaurant1.restaurant_followers.count.to_s, response.body
    @restaurant1.restaurant_followers.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end
end

class FollowRestaurantTest < FollowingRestaurantTest

  test "should follow a restaurant the standard way" do
    assert_difference "@restaurant2.restaurant_followers.count", 1 do
      post restaurant_relationships_path, params: { restaurant_followed_id: @restaurant2.id }
    end
    assert_redirected_to @restaurant2
  end

  test "should follow a restaurant with Hotwire" do
    assert_difference "@restaurant2.restaurant_followers.count", 1 do
      post restaurant_relationships_path(format: :turbo_stream),
           params: { restaurant_followed_id: @restaurant2.id }
    end
  end
end

class UnfollowRestaurantTest < FollowingRestaurantTest

  test "should unfollow a restaurant the standard way" do
    @user2 = users(:user_2)
    log_in_as(@user2)
    @restaurant2 = restaurants(:two)
    @user2.restaurant_follow(@restaurant2)
    @relationship1 = @user2.active_restaurant_relationships.find_by(restaurant_followed_id: @restaurant2.id)
    assert_difference "@user2.restaurant_following.count", -1 do
      delete restaurant_relationship_path(@relationship1)
    end
    assert_response :see_other
    assert_redirected_to @restaurant2
  end

  test "should unfollow a restaurant with Hotwire" do
    @user2 = users(:user_2)
    log_in_as(@user2)
    @restaurant2 = restaurants(:two)
    @user2.restaurant_follow(@restaurant2)
    @relationship1 = @user2.active_restaurant_relationships.find_by(restaurant_followed_id: @restaurant2.id)
    assert_difference "@user2.restaurant_following.count", -1 do
      delete restaurant_relationship_path(@relationship1, format: :turbo_stream)
    end
  end
end
