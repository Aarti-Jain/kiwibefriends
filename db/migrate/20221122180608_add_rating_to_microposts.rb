class AddRatingToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :rating, :integer
  end
end
