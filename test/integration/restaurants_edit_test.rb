require "test_helper"

class RestaurantsEditTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user  = users(:michael)
    @normal_user = users(:archer)
    @restaurant  = restaurants(:one)
  end

  test "should redirect edit restaurant when logged in as wrong user" do
    log_in_as(@normal_user)
    get edit_restaurant_path(@restaurant)
    assert_equal "Users cannot edit Restaurants", flash[:danger]
    assert_redirected_to root_url
  end

  test "should redirect update restaurant when logged in as wrong user" do
    log_in_as(@normal_user)
    patch restaurant_path(@restaurant), params: { restaurant: { name: "New Pizza Restaurant",
                                                                description: "description"} }
    assert_equal "Users cannot edit Restaurants", flash[:danger]
    assert_redirected_to root_url
  end

  test "restaurant unsuccessful edit" do
    log_in_as(@admin_user)
    get edit_restaurant_path(@restaurant)
    assert_template 'restaurants/edit'
    patch restaurant_path(@restaurant), params: { restaurant: { name:  "",
                                                                description: " "} }
    assert_template 'restaurants/edit'
  end

  test "restaurant successful edit" do
    log_in_as(@admin_user)
    get edit_restaurant_path(@restaurant)
    assert_template 'restaurants/edit'
    name        = "New Pizza Restaurant"
    description = "Free Pizza for everyone!"
    patch restaurant_path(@restaurant), params: { restaurant: { name: name,
                                                                description: description} }
    assert_not flash.empty?
    assert_redirected_to @restaurant
    @restaurant.reload
    assert_equal name,  @restaurant.name
    assert_equal description, @restaurant.description
  end
end
