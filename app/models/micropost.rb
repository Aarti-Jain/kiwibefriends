class Micropost < ApplicationRecord
  has_many :passive_likes,
           class_name: "Like",
           foreign_key: "liked_id",
           dependent: :destroy

  has_many :likers,
           through: :passive_likes,
           source: :liker

  belongs_to :user
  belongs_to :restaurant
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size: { less_than: 5.megabytes,
                              message:   "should be less than 5MB" }
  validates :restaurant_id, presence: true
  validates :rating, presence: true, inclusion: { in: (1..5) }
end
