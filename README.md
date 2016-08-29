# Prynt Coding Challege 
```
In this coding challenge, we'd like to see your ability to code a backend application
 
You'll build a Ruby app from scratch. You can use the framework of your choice. The goal of this challenge is to create a collaborative platform where anyone can see, add edit and delete tasks (title and description). 
 
1. Create the backend APIs to make this app possible.
2. Add the possibility to assign a task to multiple users
3. Add the possibility to create a user via a facebook token. (an API with a facebook token as param should create a facebook user in the database)  
4. BONUS - authenticate the users
5. Extra Bonus - that you totally shouldn't feel obligated to do as it can be really long - Create a nice Front-end
Don't forget to create a documentation! 
```

## Dependencies
- Ruby Version 2.2.2
- Rails Version 5.0

## Setup
Run `bundle install` to install any dependency gems

## Database
This project uses SQLite, simply because there will be no production

Run `rake db:create` to create the database

Run `rake db:migrate` to run the migrations and create the `db/schema.rb`

## Server
After you've installed all the gems and created the database, you are ready to run the server:

Run `rails server` and open your web browser to `http://localhost:3000`

## Endpoints
All endpoints require an authentication token in the headers

### Users
GET `/users` - returns all users in an array

GET `/users/:id` - returns a single user object 

should return:
```
{
  "id": 1,
  "uid": "10104414099326421",
  "name": "Ian Florentino",
  "prynt_auth_token": "995c949623a3c4d11e5e0bade844b46a",
  "provider": "facebook",
  "tasks": [
    {
      "id": 1,
      "title": "Foo",
      "description": "Bar"
    }
  ]
}
```

PATCH/PUT `/users/:id` - updates a single user and returns the updated user object

DELETE `/users/:id` - deletes a single user 

### Tasks
GET `/tasks` - returns all tasks in an array

POST `/tasks` - creates a task

POST '/tasks/:id/assign' - assigns a task to a user

POST with body:
```
{
  "user_id": 2
}
```

expect response with:
```
{
  "id": 1,
  "title": "Foo",
  "description": "Bar",
  "users": [
    {
      "id": 1,
      "uid": "10104414099326421",
      "name": "Ian Florentino",
      "prynt_auth_token": "995c949623a3c4d11e5e0bade844b46a",
      "provider": "facebook"
    },
    {
      "id": 2,
      "uid": "5",
      "name": "Baz Bar",
      "prynt_auth_token": "8329e42cb8ae4f8c14cb7e5c39979207",
      "provider": "facebook"
    }
  ]
}
```

POST '/tasks/:id/unassign' - unassigns a task to a user

POST with body:
```
{
  "user_id": 2
}
```

expect response with:
```
{
  "id": 1,
  "title": "Foo",
  "description": "Bar",
  "users": [
    {
      "id": 1,
      "uid": "10104414099326421",
      "name": "Ian Florentino",
      "prynt_auth_token": "995c949623a3c4d11e5e0bade844b46a",
      "provider": "facebook"
    }
  ]
}
```

GET `/tasks/:id` - returns a single task object

should return:
```
{
  "id": 1,
  "title": "Foo",
  "description": "Bar",
  "users": [
    {
      "id": 1,
      "uid": "10104414099326421",
      "name": "Ian Florentino",
      "prynt_auth_token": "995c949623a3c4d11e5e0bade844b46a",
      "provider": "facebook"
    }
  ]
}
```

PATCH/PUT `/tasks/:id` - updates a single task and returns the updated task object

DELETE `/tasks/:id` - deletes a single task

### Facebook Sign In 
This project assumes that the client side will be using Facebook's JavaScript SDK and thus sending the response object containing the `accessToken` and `signedRequest`. To test this flow, navigate to `http://localhost:3000` and click `Sign In` and authenticate through Facebook's OAuth flow.

GET|POST `/auth/:provider/callback` - accepts the oauth object and creates the user object from the basic facebook data

POST with body:
```
{
  "accessToken": "EAACjYul4uX8BAOEX01YkE0kRkETAmEDyL9wzRj8IUhTvZBTKR…GJ4jOqyXKrDQoNxvBG85vAVcZC1yAE6MZCZBu0DSrTOeAZDZD", 
  "userID": "10104414099326421", 
  "expiresIn": 3902, 
  "signedRequest": "w-vNCiiaYHXmv7W8kVM1K2-lIekOZe1pv2rwNcWlCwk.eyJhbG…M2MDA5OCwidXNlcl9pZCI6IjEwMTA0NDE0MDk5MzI2NDIxIn0"
}
```

expect response of:
```
{
  "id": 1,
  "uid": "10104414099326421",
  "name": "Ian Florentino",
  "prynt_auth_token": "995c949623a3c4d11e5e0bade844b46a",
  "provider": "facebook",
  "tasks": [ ]
}
```

### Logout
GET|DELETE `/logout` - changes users authentication token 'logs out' user

## Tests 
Run `rails test` to run all tests for the project (uses Minitest)
