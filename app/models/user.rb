class User < ApplicationRecord
  has_many :microposts, dependent: :destroy

  has_many :active_relationships,
           class_name:  "Relationship",
           foreign_key: "follower_id",
           dependent:   :destroy

  has_many :passive_relationships,
           class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy

  has_many :active_restaurant_relationships,
           class_name: "RestaurantRelationship",
           foreign_key: "restaurant_follower_id",
           dependent: :destroy

  has_many :following,
           through: :active_relationships,
           source: :followed

  has_many :followers,
           through: :passive_relationships,
           source: :follower

  has_many :restaurant_following,
           through: :active_restaurant_relationships,
           source: :restaurant_followed

  has_many :active_likes,
           class_name: "Like",
           foreign_key: "liker_id",
           dependent: :destroy

  has_many :liking,
           through: :active_likes,
           source: :liked

  has_one_attached :image

  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  validates :image,    content_type: { in: %w[image/jpeg image/gif image/png],
                                       message: "must be a valid image format" },
                       size:         { less_than: 5.megabytes,
                                       message:   "should be less than 5MB" }

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a user's status feed.
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    restaurant_followed_ids = "SELECT restaurant_followed_id from restaurant_relationships
                                WHERE restaurant_follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR restaurant_id IN (#{restaurant_followed_ids})
                     OR user_id = :user_id", user_id: id)
             .includes(:user, image_attachment: :blob)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Relationship
  # Follows a user.
  def follow(other_user)
    following << other_user unless self == other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # RestaurantRelationship
  # Follows a restaurant.
  def restaurant_follow(other_restaurant)
    restaurant_following << other_restaurant
  end

  # Unfollows a restaurant.
  def restaurant_unfollow(other_restaurant)
    restaurant_following.delete(other_restaurant)
  end

  # Returns true if the current user is following the other user.
  def restaurant_following?(other_restaurant)
    restaurant_following.include?(other_restaurant)
  end

  # Likes a micropost
  def like(other_micropost)
    liking << other_micropost
  end

  # Unlikes a micropost
  def unlike(other_micropost)
    liking.delete(other_micropost)
  end

  # Returns true if the current user is liked the other micropost
  def liking?(other_micropost)
    liking.include?(other_micropost)
  end

  def users_you_may_know
    people_you_may_know = "
      SELECT mutual.followed_id
      FROM
            (SELECT rr.followed_id
            FROM Users u
            INNER JOIN Relationships r on r.follower_id = u.id
            INNER JOIN Relationships rr on rr.follower_id = r.followed_id
            WHERE u.id = :id AND rr.followed_id NOT IN
                  (SELECT rrr.followed_id from Relationships rrr
                  WHERE rrr.follower_id = u.id)
      ) mutual
      GROUP BY mutual.followed_id
      ORDER BY COUNT(*) DESC
    "
    User.where("id IN (#{people_you_may_know})", id: id)
  end

  def users_with_same_taste
    people_with_same_taste = "
      SELECT followers.restaurant_follower_id
      FROM
        (SELECT rr.restaurant_follower_id
        FROM Users u
              INNER JOIN restaurant_relationships r on r.restaurant_follower_id = u.id
              INNER JOIN restaurant_relationships rr on rr.restaurant_followed_id = r.restaurant_followed_id
        WHERE u.id = :id AND rr.restaurant_follower_id != u.id) followers
      GROUP BY followers.restaurant_follower_id
      ORDER BY COUNT(*) DESC
    "
    User.where("id IN (#{people_with_same_taste})", id: id)
  end

  def restaurants_you_might_like
    restaurant_ids = "
    SELECT restaurant_followed_id
    FROM restaurant_relationships
    WHERE restaurant_follower_id IN (
      SELECT followers.restaurant_follower_id
      FROM
        (SELECT rr.restaurant_follower_id
        FROM Users u
              INNER JOIN restaurant_relationships r on r.restaurant_follower_id = u.id
              INNER JOIN restaurant_relationships rr on rr.restaurant_followed_id = r.restaurant_followed_id
        WHERE u.id = :id AND rr.restaurant_follower_id != u.id) followers
      GROUP BY followers.restaurant_follower_id
      ORDER BY COUNT(*) DESC
    )
    GROUP BY restaurant_followed_id
    ORDER BY COUNT(*) DESC
    "
    Restaurant.where("id IN (#{restaurant_ids})", id: id)
  end
end
