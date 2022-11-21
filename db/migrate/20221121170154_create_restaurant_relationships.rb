class CreateRestaurantRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_relationships do |t|
      t.integer :restaurant_follower_id
      t.integer :restaurant_followed_id

      t.timestamps
    end
    add_index :restaurant_relationships, :restaurant_follower_id
    add_index :restaurant_relationships, :restaurant_followed_id
    add_index :restaurant_relationships, [:restaurant_follower_id, :restaurant_followed_id], 
                                          unique: true,
                                          name: 'add_index_rest_on_follower_and_followed'
  end
end
