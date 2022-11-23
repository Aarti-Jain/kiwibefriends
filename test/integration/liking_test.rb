require "test_helper"

class LikingTest < ActionDispatch::IntegrationTest
  test "user should like a post the standard way" do
    @user      = users(:lana)
    @micropost = microposts(:orange)
    log_in_as(@user)
    assert_difference "@user.liking.count", 1 do
      post likes_path, params: { liked_id: @micropost.id }
    end
  end

  test "user should unlike a user the standard way" do
    @user      = users(:archer)
    @micropost = microposts(:orange)
    log_in_as(@user)
    @user.like(@micropost)
    @like = @user.active_likes.find_by(liked_id: @micropost.id)
    assert_difference "@user.liking.count", -1 do
      delete like_path(@like)
    end
  end
end
