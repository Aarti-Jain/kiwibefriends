require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  test "leaderboard should display restaurants sorted by average rating" do
    log_in_as(users(:michael))
    get leaderboard_path
    assert_template 'restaurants/leaderboard'

    # TODO
  end
end
