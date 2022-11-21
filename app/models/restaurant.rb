class Restaurant < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 255 }
end
