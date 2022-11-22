require "test_helper"

class RestaurantRelationshipTest < ActiveSupport::TestCase
  def setup
    @restaurant_relationship = RestaurantRelationship.new(
                               restaurant_follower_id: users(:michael).id,
                               restaurant_followed_id: restaurants(:one).id)
  end

  test "restaurant relationship should be valid" do
    assert @restaurant_relationship.valid?
  end

  test "restaurant relationship should require a restaurant_follower_id" do
    @restaurant_relationship.restaurant_follower_id = nil
    assert_not @restaurant_relationship.valid?
  end

  test "restaurant relationship should require a restaurant_followed_id" do
    @restaurant_relationship.restaurant_followed_id = nil
    assert_not @restaurant_relationship.valid?
  end

  test "user should follow and unfollow a restaurant" do
    user1       = users(:lana)
    restaurant1 = restaurants(:two)
    restaurant2 = restaurants(:one)

    # user1 not following any restaurants
    assert_not user1.restaurant_following?(restaurant1)
    assert_not user1.restaurant_following?(restaurant2)

    # both restaurants are not being followed
    assert_not restaurant1.restaurant_followers.include?(user1)
    assert_not restaurant2.restaurant_followers.include?(user1)

    # user1 follows both restaurants
    user1.restaurant_follow(restaurant1)
    user1.restaurant_follow(restaurant2)
    assert user1.restaurant_following?(restaurant1)
    assert user1.restaurant_following?(restaurant2)
    assert restaurant1.restaurant_followers.include?(user1)
    assert restaurant2.restaurant_followers.include?(user1)

    # user1 unfollows both restaurants
    user1.restaurant_unfollow(restaurant1)
    user1.restaurant_unfollow(restaurant2)
    assert_not user1.restaurant_following?(restaurant1)
    assert_not user1.restaurant_following?(restaurant2)
    assert_not restaurant1.restaurant_followers.include?(user1)
    assert_not restaurant2.restaurant_followers.include?(user1)
  end
end
