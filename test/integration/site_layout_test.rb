require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links not logged in" do
    get root_path
    follow_redirect!
    assert_template 'sessions/new'
  end

  test "layout links logged in" do
    log_in_as(users(:michael))
    get root_path
    assert_template 'static_pages/home'
  end
end
