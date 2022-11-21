module RestaurantsHelper

  # Returns the Gravatar for the given restaurant.
  def gravatar_for_restaurant(restaurant, size: 80)
    gravatar_id  = Digest::MD5::hexdigest(restaurant.name.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: restaurant.name, class: "gravatar")
  end
end
