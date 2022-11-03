# [Kiwi Be Friends](https://kiwi-be-friends-cosi166.herokuapp.com/)
A social networking website that allows users to rate, review and share restaurants with their friends!
Available @ https://kiwi-be-friends-cosi166.herokuapp.com/
## Team 5
- [Mahmoud Salah](https://www.github.com/MahmoudSalah02)
- [Aari Jain](https://www.github.com/Aarti-Jain)
- [Brian Liao](https://www.github.com/bliaowey)
- [Zixin Zhang](https://www.github.com/GodDamnGitHub)
## Features
- Secure Login :ballot_box_with_check:
## Roadmap
- Networking Element
- Content Sharing Method
- Messaging System
- Real-Time Notifications
- Search for posts/users/groups
- Create/Join Groups
## Routes
#### Root
```http
  GET /
```
Landing page where users login in
#### Sign up
```http
  GET /signup
```
Sign up page where users create an account
#### User
```http
  GET /User/user_id
```
User profile page
#### Restaurant
```http
  GET /Restaurant/restaurant_id
```
Restaurant page
#### Group
```http
  GET /Group/group_id
```
Group page
## APIs
- Maps Embed API
## Gems
- Faker :ballot_box_with_check:
- image_processing
- aws-sdk-s3
## Prototype
Designed via Balsamiq @ [Paper Prototype and UX flows](https://example.com)
## Schema
### Entities:
`User` (user_id, name, bio, age, email, password)
`Post` (user_id, restaurant_id, group_id, content, rating, picture)
`Comment` (post_id, user_id, comment)
`Like` (like_id, user_id, post_id)
`Restaurant` (restaurant_id, name, website, hours, location, price_range)
`Group` (group_id, name, description, members_count, admin)
### Relations:
- One-to-Many
`user_posts`: User(user_id) → Post(user_id)
`user_comment`: User(user_id) → Comment(user_id)
`post_comments`: Post(post_id) → Comment(post_id)
`user_likes`: User(user_id) → Like(user_id)
`post_likes`: Post(post_id) → Like(post_id)
`restaurant_posts`: Restaurant(restaurant_id) → Post(restaurant_id)
`group_posts`: Group(group_id) → Post(group_id)
- Many-to-Many
`user_in_groups`: User(user_id) → Group(user_id)
`user_follows_restaurants`: User(user_id) → Restaurant(restaurant_id)
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