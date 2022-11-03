# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

#Users
for i in 0..50 do
    user_name = Faker::Name.name
    user_age = Faker::Number.number(digits: 2)
    user_email = Faker::Internet.email 
    user_bio = Faker::Name.name
    user_password = Faker::String.random
    User.new(name:user_name, age:user_age, email:user_email, bio:user_bio, password:user_password).save
end

#Restaurants
for i in 0..50 do
    restaurant_name = Faker::Restaurant.name
    restaurant_location = Faker::WorldCup.city
    restaurant_price_range =Faker::Number.number(digits: 2)
    Restaurant.new(name:restaurant_name,location:restaurant_location,price_range:restaurant_price_range).save
end

#Posts
for i in 0..50 do
    post_user_id = User.all.sample(1)[0].id
    post_restaurant_id = Restaurant.all.sample(1)[0].id
    post_group_id = Group.all.sample(1)[0].id
    post_content = Faker::Restaurant.name
    post_rating = rand(1..6) #this might be wrong
    Post.new(user_id:post_user_id, restaurant_id:post_restaurant_id, group_id:post_group_id, content: post_content, rating: post_rating).save
end

#Comments
for i in 0..50 do
    comment_post_id = Post.all.sample(1)[0].id
    comment_user_id = User.all.sample(1)[0].id
    comment_content = Faker::Restaurant.name
    Comment.new(post_id:comment_post_id,user_id:comment_user_id,content:comment_content).save
end

#Likes
for i in 0..50 do
    like_user_id = User.all.sample(1)[0].id
    like_post_id = Post.all.sample(1)[0]
    Like.new(user_id: like_user_id, post_id: like_post_id).save
end

#Groups
for i in 0..50 do
    group_member_count = rand(1..100)
    group_admin = User.all.sample(1)[0].id
    group_name = Faker::Nation.capital_city
    group_description = Faker::ChuckNorris.fact
    Group.new(member_count: group_member_count, admin: group_admin, name: group_name, description: group_description)
end