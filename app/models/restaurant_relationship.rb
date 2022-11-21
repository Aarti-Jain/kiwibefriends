class RestaurantRelationship < ApplicationRecord
  belongs_to :restaurant_follower, class_name: "User"
  belongs_to :restaurant_followed, class_name: "Restaurant"
  validates :restaurant_follower_id, presence: true
  validates :restaurant_followed_id, presence: true
end
