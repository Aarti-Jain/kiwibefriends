require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  def setup
    @restaurant = Restaurant.new(name: "Pizza Hut", description: "American multinational restaurant chain and international franchise")
  end

  test "should be valid" do
    assert @restaurant.valid?
  end

  test "name should be present" do
    @restaurant.name = "     "
    assert_not @restaurant.valid?
  end

  test "description should be present" do
    @restaurant.description = "     "
    assert_not @restaurant.valid?
  end

  test "name should not be too long" do
    @restaurant.name = "a" * 51
    assert_not @restaurant.valid?
  end

  test "description should not be too long" do
    @restaurant.description = "a" * 256
    assert_not @restaurant.valid?
  end

  test "name should be unique" do
    duplicate_restaurant = @restaurant.dup
    duplicate_restaurant.name = @restaurant.name.upcase
    @restaurant.save
    assert_not duplicate_restaurant.valid?
  end
end
