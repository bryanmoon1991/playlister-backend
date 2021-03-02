require 'rest_client'
require 'dotenv'
Dotenv.load('./.env')

class Api::V1::AuthController < ApplicationController

  # skip_before_action :authorized, only: [:spotify_request]

  def spotify_request
    url = "https://accounts.spotify.com/authorize"
    query_params = {
      client_id: ENV['CLIENT_ID'],
      response_type: 'code',
      # redirect_uri: 'http://localhost:3000/api/v1/user',
      redirect_uri: 'https://playlister-app-api.herokuapp.com/api/v1/user',
      scope: "user-library-read 
      user-library-modify 
      user-top-read 
      user-follow-modify
      user-follow-read
      user-modify-playback-state 
      playlist-modify-public 
      playlist-modify-private 
      ugc-image-upload 
      user-read-recently-played 
      user-read-email",
     show_dialog: true
    }
    redirect_to "#{url}?#{query_params.to_query}"
  end


end