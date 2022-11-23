require 'faker'

# Create a main sample user.
User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar",
    admin: true)

# Generate a bunch of additional users.
99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password)
end

# Generate a bunch of Restaurants
99.times do
  name = Faker::Restaurant.unique.name
  description = Faker::Restaurant.description
  Restaurant.create!(name: name,
                     description: description[0...100])
end

# Generate microposts
users = User.all
users.each do |user|
  restaurants_subset = Restaurant.order('RANDOM()').take(5)
  restaurants_subset.each do |restaurant|
    content = Faker::Lorem.sentence(word_count: Faker::Number.between(from: 10, to: 20))[0...200]
    rating = Faker::Number.between(from: 1, to: 5)
    restaurant_id = restaurant.id
    user.microposts.create!(content: content, 
                            restaurant_id:restaurant_id,
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
  restaurants_to_follow = Restaurant.order('RANDOM()').take(5)
  restaurants_to_follow.each do |curr_restaurant|
    curr_user.restaurant_follow(curr_restaurant)
  end
end

# Create restaurant following relationships.
Micropost.all.each do |micropost|
  User.order('RANDOM()').take(Faker::Number.between(from: 30, to: 50)).each do |curr_user|
    curr_user.like(micropost)
  end
end
