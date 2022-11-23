class Restaurant < ApplicationRecord
  has_many :microposts, dependent: :destroy

  has_many :passive_restaurant_relationships, 
            class_name:  "RestaurantRelationship",
            foreign_key: "restaurant_followed_id",
            dependent:   :destroy

  has_many :restaurant_followers,
           through: :passive_restaurant_relationships,
           source: :restaurant_follower

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 255 }

  def average_rating
    average = Micropost.where(restaurant_id: id).average(:rating)
    if average.nil?
      1
    else
      average.round(1)
    end
  end
end
