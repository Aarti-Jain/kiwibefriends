require 'faker'
require "uri"
require "net/http"

# creating an admin user
User.create!(name:  "admin",
             email: "admin@gmail.com",
             password: "admin123",
             password_confirmation: "admin123",
             admin: true)

# creating a bunch of users
(1..20).each do |i|
  name  = Faker::Name.name
  email = "user-#{i+1}@gmail.com"
  password = "password"
  new_user = User.create!(name:  name,
                          email: email,
                          password: password,
                          password_confirmation: password)
  new_user.image.attach(
    io:  File.open(File.join(Rails.root,"app/assets/images/users/#{i}.jpg")),
    filename: "#{i}.jpg"
  )
end

# Use Google Places API - Text Search to get a list of 20 Restaurants
url = URI("https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants%20in%20Massachusetts&key=#{Rails.application.credentials.google_maps_api_key}")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)

response = https.request(request)
restaurants_data = JSON.parse(response.read_body)

# Store that data in the restaurants table
i = 1
restaurants_data["results"].each do |restaurant|
  new_restaurant = Restaurant.create!(name: restaurant["name"],
                                      description: restaurant["formatted_address"].split(",")[1..2].join(",").strip!,
                                      latitude: restaurant["geometry"]["location"]["lat"],
                                      longitude: restaurant["geometry"]["location"]["lng"])
  new_restaurant.image.attach(
    io:  File.open(File.join(Rails.root,"app/assets/images/restaurants/#{i}.jpg")),
    filename: "#{i}.jpg"
  )
  i += 1
end

# Generate a bunch of microposts
users = User.all
i = 1
users.each do |user|
  restaurants_subset = Restaurant.order('RANDOM()').take(5)
  restaurants_subset.each do |restaurant|
    content = Faker::Restaurant.review[0...200]
    rating = Faker::Number.between(from: 1, to: 5)
    restaurant_id = restaurant.id
    new_micropost = user.microposts.create!(content: content,
                                            restaurant_id: restaurant_id,
                                            rating: rating)
    new_micropost.image.attach(
      io:  File.open(File.join(Rails.root,"app/assets/images/food/#{i % 28 + 1}.jpg")),
      filename: "#{i % 28}.jpg"
    )
    i += 1
  end
end

# creating following relationships.
users = User.all
users.each do |curr_user|
  users_to_follow = User.order('RANDOM()').take(3)
  users_to_follow.each do |user_to_follow|
    curr_user.follow(user_to_follow)
  end
end

# creating restaurant following relationships.
users = User.all
users.each do |curr_user|
  restaurants_to_follow = Restaurant.order('RANDOM()').take(3)
  restaurants_to_follow.each do |curr_restaurant|
    curr_user.restaurant_follow(curr_restaurant)
  end
end

# creating micrpost liking relationships.
Micropost.all.each do |micropost|
  User.order('RANDOM()').take(Faker::Number.between(from: 2, to: 10)).each do |curr_user|
    curr_user.like(micropost)
  end
end
