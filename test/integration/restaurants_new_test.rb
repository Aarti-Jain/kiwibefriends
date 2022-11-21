require "test_helper"

class RestaurantsNewTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user  = users(:michael)
    @normal_user = users(:archer)
    @restaurant  = restaurants(:one)
  end

  test "should redirect new restaurant when logged in as wrong user" do
    log_in_as(@normal_user)
    get restaurants_new_path
    assert_equal "Users cannot edit Restaurants", flash[:danger]
    assert_redirected_to root_url
  end

  test "should redirect create restaurant when logged in as wrong user" do
    log_in_as(@normal_user)
    post restaurants_path, params: { restaurant: { name:  "Pizza",
                                                     description: "Pizza Restaurant" } }
    assert_equal "Users cannot edit Restaurants", flash[:danger]
    assert_redirected_to root_url
  end

  test "invalid new restaurant information" do
    log_in_as(@admin_user)
    get restaurants_new_path
    assert_no_difference 'Restaurant.count' do
      post restaurants_path, params: { restaurant: { name:  "",
                                                     description: "" } }
    end
    assert_template 'restaurants/new'
  end

  test "valid new restaurant information" do
    log_in_as(@admin_user)
    get restaurants_new_path
    assert_difference 'Restaurant.count', 1 do
      post restaurants_path, params: { restaurant: { name:  "Pizza",
                                                     description: "Pizza Restaurant" } }
    end
    follow_redirect!
    assert_template 'restaurants/show'
  end
end
