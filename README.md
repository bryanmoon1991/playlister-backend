## Perfect Playlist- API

Check out the [frontend repo](https://github.com/bryanmoon1991/playlister-frontend) for more details on this app

## Run it Locally

To successfully get this app running locally you will have to first create a [Spotify Developer](https://developer.spotify.com/) profile and [create an app](https://developer.spotify.com/dashboard/applications) in order to acquire a CLIENT_ID and a CLIENT_SECRET. Once you have them, create a .env file at the root of this directory and paste in both items like this:

```
CLIENT_ID=<YOUR CLIENT ID>
CLIENT_SECRET=<YOUR CLIENT SECRET>
```

In your Spotify developer profile, open the settings in your app and add the following redirect uri's

- http://localhost:3000/
- http://localhost:3000/api/v1/user
- http://localhost:3000/api/v1/profile

Then, in the controllers/api/v1/ directory, go to the auth_controller.rb & users_controller.rb files and comment out the lines using the endpoints for the deployed version and comment in the lines using the localhost endpoints.

Once the endpoints have been adjusted to localhost, run

```ruby
rails db:create
rails db:migrate
rails s
```

Once your server is running locally on port 3000 navigate to the frontend directory and spin up the frontend server to port 3001
