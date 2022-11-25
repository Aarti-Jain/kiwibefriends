module RestaurantsHelper

  # Returns the Gravatar for the given restaurant.
  def gravatar_for_restaurant(restaurant, options = { size: 80 })
    size = options[:size]
    if restaurant.image.attached?
      image_tag(restaurant.image, alt: restaurant.name, class: "gravatar", size: size)
    else
      gravatar_id  = Digest::MD5::hexdigest(restaurant.name.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: restaurant.name, class: "gravatar")
    end
  end
end
