class RestaurantRelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @restaurant = Restaurant.find(params[:restaurant_followed_id])
    current_user.restaurant_follow(@restaurant)
    respond_to do |format|
      format.html { redirect_to @restaurant }
      format.turbo_stream
    end
  end

  def destroy
    @restaurant = RestaurantRelationship.find(params[:id]).restaurant_followed
    current_user.restaurant_unfollow(@restaurant)
    respond_to do |format|
      format.html { redirect_to @restaurant, status: :see_other }
      format.turbo_stream
    end
  end
end
