class Restaurant < ApplicationRecord
  has_many :microposts, dependent: :destroy

  has_many :passive_restaurant_relationships, 
            class_name:  "RestaurantRelationship",
            foreign_key: "restaurant_followed_id",
            dependent:   :destroy

  has_many :restaurant_followers,
           through: :passive_restaurant_relationships,
           source: :restaurant_follower

  has_one_attached :image

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 255 }

  validates :image,       content_type: { in: %w[image/jpeg image/gif image/png],
                                          message: "must be a valid image format" },
                          size:         { less_than: 5.megabytes,
                                          message:   "should be less than 5MB" }

  def average_rating
    average = Micropost.where(restaurant_id: id).average(:rating)
    if average.nil?
      1
    else
      average.round(1)
    end
  end

  def self.leaderboard(chosen_filter)
    Restaurant.joins(:microposts)
              .where('microposts.created_at >= ?', chosen_filter)
              .select('restaurants.id,
                      avg(microposts.rating) as avg_rating')
              .group('restaurants.id')
              .order('avg_rating desc')
  end
end
