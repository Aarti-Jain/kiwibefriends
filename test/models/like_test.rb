require "test_helper"

class LikeTest < ActiveSupport::TestCase
  def setup
    @like = Like.new(liker_id: users(:michael).id,
                     liked_id: microposts(:cat_video).id)
  end

  test "like should be valid" do
    assert @like.valid?
  end

  test "like should require a liker_id" do
    @like.liker_id = nil
    assert_not @like.valid?
  end

  test "like should require a liked_id" do
    @like.liked_id = nil
    assert_not @like.valid?
  end
end
