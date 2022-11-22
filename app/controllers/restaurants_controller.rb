class RestaurantsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :create, 
                                        :edit, :update, :destroy, :restaurant_followers]
  before_action :is_admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.paginate(page: params[:page])
  end
  
  def show
    @restaurant = Restaurant.find(params[:id])
    @microposts = @restaurant.microposts.paginate(page: params[:page])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:success] = "New Restaurant Created!"
      redirect_to @restaurant
    else
      render 'new'
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      flash[:success] = "Restaurant updated"
      redirect_to @restaurant
    else
      render 'edit'
    end
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    flash[:success] = "Restaurant deleted"
    redirect_to restaurants_url
  end

  def restaurant_followers
    @title = "Restaurant Followers"
    @restaurant = Restaurant.find(params[:id])
    @users = @restaurant.restaurant_followers.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  private

    def restaurant_params
      params.require(:restaurant).permit(:name, :description)
    end

    def is_admin_user
      unless current_user.admin?
        flash[:danger] = "Users cannot edit Restaurants"
        redirect_to(root_url, status: :see_other) 
      end
    end
end
