require "test_helper"

class RestaurantRelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "create restaurant relationship should require logged-in user" do
    assert_no_difference 'RestaurantRelationship.count' do
      post restaurant_relationships_path
    end
    assert_redirected_to login_url
  end

  test "destroy restaurant relationship should require logged-in user" do
    assert_no_difference 'RestaurantRelationship.count' do
      delete restaurant_relationship_path(restaurant_relationships(:rel_one))
    end
    assert_redirected_to login_url
  end
end
