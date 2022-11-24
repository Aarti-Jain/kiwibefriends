require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "home should get login when user is not logged in" do
    get root_path
    assert_redirected_to login_url
  end

  test "should get home when user logged in" do
    log_in_as(users(:michael))
    get root_path
    assert_response :success
    assert_select "title", "Kiwi Be Friends"
  end
end
