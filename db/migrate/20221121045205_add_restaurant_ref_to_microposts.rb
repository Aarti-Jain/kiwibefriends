class AddRestaurantRefToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_reference :microposts, :restaurant, null: false, foreign_key: true
  end
end
