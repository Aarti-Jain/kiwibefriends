# [Kiwi Be Friends](https://kiwi-be-friends-cosi166.herokuapp.com/)

A social networking website that allows users to rate, review and share restaurants with their friends!

Available @ https://kiwi-be-friends-cosi166.herokuapp.com/

## Team 5
- [Mahmoud Salah](https://www.github.com/MahmoudSalah02)
- [Aari Jain](https://www.github.com/Aarti-Jain)
- [Brian Liao](https://www.github.com/bliaowey)
- [Zixin Zhang](https://www.github.com/GodDamnGitHub)

## Features
- Secure Login/Sign up :ballot_box_with_check:
- Home Feed with relevant reviews :ballot_box_with_check:
- Post a Review (rating/image/text) :ballot_box_with_check:
- Like/Unlike a review :ballot_box_with_check:
- Follow/Unfollow other Users/Restaurants :ballot_box_with_check:
- Leaderboard of Restaurants by Rating :ballot_box_with_check:
- Search Functioanlity for Users/Restaurants :ballot_box_with_check:
- Interactive Map of all Restaurants :ballot_box_with_check:
- Directions to a Restaurant :ballot_box_with_check:
- Recommendation Algo for People you may know :ballot_box_with_check:
- Recommednation Algo for People with same taste :ballot_box_with_check:
- Recommendation Algo for Restaurants you may like :ballot_box_with_check:


## Roadmap
- Create/Join User groups
- ML algorithim for relevant Posts
- Mobile App 
- Real-Time Notification system

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


## APIs
- [Google Maps Places API](https://developers.google.com/maps/documentation/places/web-service/overview)
- [Google Maps Photos API](https://developers.google.com/maps/documentation/places/web-service/photos)
- [Yelp Fusion API](https://docs.developer.yelp.com/docs/fusion-intro)


## Gems
- bcrypt
- faker 
- bootstrap-sass
- aws-sdk-s3
- turbo-rails
- image_processing
- active_storage_validations

## Prototype

Paper Prototype and UX flows @ [Balsamiq](https://drive.google.com/file/d/14DPjYT-WpjN2JeTZloeKtNOUVTSn68ZI/view?usp=sharing)

## Schema

ER Diagram @ [dbdiagram](https://dbdiagram.io/d/638e3b7cbae3ed7c4544e0d0)

### Entities:

`User` (id, name, email, password_digest, remember_digest, admin)

`Restaurant` (id, name, description)

`Relationship` (id, follower_id, followed_id)

`RestaurantRelationship` (id, restaurant_follower_id, restaurant_followed_id)

`Micropost` (id, user_id, restaurant_id, content, rating)

`Like` (id, liker_id, liked_id)




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
## Run Tests
To run all Tests, Fire command prompt and run command:
```bash
rails t
```
