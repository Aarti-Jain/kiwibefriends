require "test_helper"

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @restaurant = restaurants(:one)
    @micropost = @user.microposts.build(content: "Lorem ipsum",
                                        restaurant_id: @restaurant.id,
                                        rating: 1)
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "restaurant id should be present" do
    @micropost.restaurant_id = nil
    assert_not @micropost.valid?
  end

  test "rating should be present" do
    @micropost.rating = nil
    assert_not @micropost.valid?
  end

  test "rating should be between 1 and 5" do
    @micropost.rating = 0
    assert_not @micropost.valid?

    @micropost.rating = 3
    assert @micropost.valid?

    @micropost.rating = 6
    assert_not @micropost.valid?
  end

  test "content should be at most 200 characters" do
    @micropost.content = "a" * 202
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end