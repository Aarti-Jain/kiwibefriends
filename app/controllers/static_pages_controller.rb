class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @no_posts = false
      if @feed_items.count.zero?
        @no_posts = true
        @feed_items = Micropost.where('rating >= 4').paginate(page: params[:page])
      end
    else
      redirect_to(login_url)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end