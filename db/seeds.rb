require 'faker'
require "uri"
require "net/http"

# creating an admin user
User.create!(name:  "admin",
             email: "admin@gmail.com",
             password: "admin123",
             password_confirmation: "admin123",
             admin: true)

# Use Google Places API - Text Search to get a list of 20 Restaurants
url = URI("https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants%20in%20Massachusetts&key=#{Rails.application.credentials.google_maps_api_key}")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)

response = https.request(request)
restaurants_data = JSON.parse(response.read_body)

# Store that data in the restaurants table
restaurants_data["results"].each do |restaurant|
  new_restaurant = Restaurant.create!(name: restaurant["name"], 
                                      description: restaurant["formatted_address"].split(",")[1..2].join(",").strip!,
                                      latitude: restaurant["geometry"]["location"]["lat"],
                                      longitude: restaurant["geometry"]["location"]["lng"])
end
