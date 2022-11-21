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

# Generate microposts for a subset of users.
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  restaurant_id = Restaurant.order('RANDOM()').first.id
  users.each { |user| user.microposts.create!(content: content, 
                                              restaurant_id:restaurant_id) }
end

# Create following relationships.
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
