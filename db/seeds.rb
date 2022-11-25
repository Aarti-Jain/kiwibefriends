require 'faker'

# creating an admin user
User.create!(name:  "admin",
             email: "admin@gmail.com",
             password: "admin123",
             password_confirmation: "admin123",
             admin: true)

# Generate a bunch of additional Users.
30.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  password = "password"
  new_user = User.create!(name:  name,
                          email: email,
                          password: password,
                          password_confirmation: password)
  # new_user.image.attach(
  #   io:  File.open(File.join(Rails.root,'app/assets/images/photo.jpg')),
  #   filename: 'photo.jpg'
  # )
end

# Generate a bunch of Restaurants
30.times do
  name = Faker::Restaurant.unique.name
  description = Faker::Restaurant.description
  new_restaurant = Restaurant.create!(name: name,
                                      description: description[0...220])
  # new_restaurant.image.attach(
  #   io:  File.open(File.join(Rails.root,'app/assets/images/photo.jpg')),
  #   filename: 'photo.jpg'
  # )
end

# Generate microposts
users = User.all
users.each do |user|
  restaurants_subset = Restaurant.order('RANDOM()').take(3)
  restaurants_subset.each do |restaurant|
    content = Faker::Restaurant.review[0...200]
    rating = Faker::Number.between(from: 1, to: 5)
    restaurant_id = restaurant.id
    user.microposts.create!(content: content,
                            restaurant_id: restaurant_id,
                            rating: rating)
  end
end

# Create following relationships.
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# Create restaurant following relationships.
users = User.all
users.each do |curr_user|
  restaurants_to_follow = Restaurant.order('RANDOM()').take(3)
  restaurants_to_follow.each do |curr_restaurant|
    curr_user.restaurant_follow(curr_restaurant)
  end
end

# Create micrpost liking relationships.
Micropost.all.each do |micropost|
  User.order('RANDOM()').take(Faker::Number.between(from: 2, to: 20)).each do |curr_user|
    curr_user.like(micropost)
  end
end
