# [Kiwi Be Friends](https://kiwi-be-friends-cosi166.herokuapp.com/)

Available @ https://kiwi-be-friends-cosi166.herokuapp.com/

------

## Team #5 Members
- [Mahmoud Salah](https://www.github.com/MahmoudSalah02) - Full Stack & DevOps
- [Aari Jain](https://www.github.com/Aarti-Jain) - DevOps & Frontend
- [Brian Liao](https://www.github.com/bliaowey) - UI Design & Frontend
- [Zixin Zhang](https://www.github.com/GodDamnGitHub) - Frontend

------

## Purpose

Looking for the best restaurants in town? Look no further than Kiwi Be Friends! Our app offers a range of features to help you discover and share the top spots in your area. From secure login and sign-up to a home feed with relevant reviews, and the ability to post your own reviews, you can easily share your food adventures with others. Plus, with our interactive map and directions, you can easily find and visit the restaurants you're interested in. And with recommendation algorithms that suggest users and restaurants based on your activity and tastes, you can easily find new recommendations and explore the culinary world. Visit Kiwi Be Friends today and start your food journey!

------

## Features

- :ballot_box_with_check: Secure login and sign up 
- :ballot_box_with_check: A home feed with relevant reviews
- :ballot_box_with_check: Post a review with a rating and image
- :ballot_box_with_check: Like and unlike reviews
- :ballot_box_with_check: Follow and unfollow other users and restaurants
- :ballot_box_with_check: Leaderboard of restaurants by rating
- :ballot_box_with_check: Search functionality for users and restaurants
- :ballot_box_with_check: Interactive map of all restaurants
- :ballot_box_with_check: Directions to a restaurant
- :ballot_box_with_check: Recommendation algorithms for people and restaurants based on your tastes and activity on the app.

------

## Paper Prototype

Paper Prototype and UX flows @ [Balsamiq](https://drive.google.com/file/d/14DPjYT-WpjN2JeTZloeKtNOUVTSn68ZI/view?usp=sharing)

-----

## Schema

ER Diagram @ [dbdiagram](https://dbdiagram.io/d/638e3b7cbae3ed7c4544e0d0)

`User` (id, name, email, password_digest, remember_digest, admin)

`Restaurant` (id, name, description, longitude, latitude)

`Relationship` (id, follower_id, followed_id)

`RestaurantRelationship` (id, restaurant_follower_id, restaurant_followed_id)

`Micropost` (id, user_id, restaurant_id, content, rating)

`Like` (id, liker_id, liked_id)

-----

## Technologies

### `Storage`

- PostgreSQL: the main DBMS to store information

- Amazon S3: persist images in production


### `APIs`

- [Google Maps JavaScript API](https://developers.google.com/maps/documentation/javascript/overview): Interactive Map to find Restaurants

- [Google Places API](https://developers.google.com/maps/documentation/places/web-service/overview): Seed data with real Restaurant

- [Geolocation API](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API): Find the current location of a User

- [Google Directions API](https://developers.google.com/maps/documentation/directions/overview): Find directions to a Restaurant

### `Gems`

- bcrypt

- faker 

- bootstrap-sass

- aws-sdk-s3

- turbo-rails

- image_processing

- active_storage_validations

-----

## Methodologies and Results

### `Short lived branches`

### `CI/CD`

- GitHub Actions: Continuous Integration: 

- Heroku Pipelines: Continuous Delivery

### `Test Driven Development (TDD)`: 

- Integration tests

- Model tests

- Controller tests

- Helper test

<i>124 runs, 468 assertions, 0 failures, 0 errors, 0 skips</i>

### `Scalability`

- Tested Scalability using Loader.io: [the Results](https://docs.google.com/document/d/11dB3cyfLf6ulpouIHU220f13UBiiupK9oZ_h11q2uxY/edit?usp=sharing)

------

### Architecture

![Software Architecture](/app/assets/images/architecture.png "Application Architecture")

------

## Routes

#### `Login`
- ##### Landing pages for the website where Users can login
```
  GET /login
```

#### `Sign up`
- ##### Sign up page where users create an account
```
  GET /signup
```

#### `Home Feed`
- ##### Shows the home feed for the logged in User
```
  GET /
```

#### `User`

- ##### Searchable list of all Users
```
  GET /users
```

- ##### User profile page
```
  GET /users/user_id
```

- ##### User edit profile form
```
  GET /users/user_id/edit
```

#### `Restaurant`

- ##### Searchable list of all Restaurants
```
  GET /restaurants
```

- ##### Show the profile page of Restaurant with restuarant_id
```
  GET /restaurants/restuarant_id
```

- ##### Edit the profile page of Restaurant with restuarant_id (Admin only)
```
  GET /restaurants/restuarant_id/edit
```

- ##### Create a new Restaurant (Admin only)
```
  GET /restaurants/new
```

#### `Leaderboard`
- ##### Show the leaderboard page of Restaurants
```
  GET /leaderboard
```

------

## Run Locally
Make sure Ruby is installed on your system. Fire command prompt and run command:
```bash
ruby -v
```
Make sure Rails is installed
```bash
rails -v
```
Clone respected git repository
```bash
git clone https://github.com/Aarti-Jain/kiwibefriends.git
```
Install all dependencies
```bash
bundle install
```
Create db and migrate schema
```bash
rake db:create
rake db:migrate
```
Now run your application
```bash
rails s
```

------

## Run Tests
To run all Tests, Fire command prompt and run command:
```bash
rails t
```

------

## Reflection
Overall, we are pleased with the product we developed over the course of the semester. However, during the development of our website, we encountered some challenges as well as had some wins. A main challenge for us was trying to find a time for everyone to meet, and setting a regular meeting schedule. Furthermore, as a team, we struggled with narrowing down our ideas into a fixed set of features that we all agreed to develop. We also had some challenges surrounding communication over slack and we weren’t consistent using Trello. Nevertheless, we all valued the experience gained from working on this product. We all learned new technologies and experimented with different tools, like integrating APIs into our app. In the end, we all enjoyed working with each other on this product.


------

## Future Roadmap

- Create/Join User groups

- ML algorithim for relevant Posts

- Mobile App 

- Real-Time Notification system
