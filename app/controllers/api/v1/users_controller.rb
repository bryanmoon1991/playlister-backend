require 'rest_client'
require 'dotenv'
require 'byebug'
Dotenv.load('./.env')

class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find_by(id: params[:id])
    if user.access_token_expired?
      user.refresh_access_token
    end
    render json: user
  end

  def create
    body = {
      grant_type: "authorization_code",
      code: params[:code],
      redirect_uri: 'http://localhost:3000/api/v1/user',
      client_id: ENV['CLIENT_ID'], 
      client_secret: ENV['CLIENT_SECRET']
    }
    auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
    auth_params = JSON.parse(auth_response.body)
    header = {
      Authorization: "Bearer #{auth_params["access_token"]}"
    }
    
    user_response = RestClient.get("https://api.spotify.com/v1/me", header)
    user_params = JSON.parse(user_response.body)
    user = User.find_by(spotify_id: user_params["id"])
    if user
        redirect_to "http://localhost:3001/users/#{user.id}"
    else
        user = User.create(email: user_params["email"], display_name: user_params["display_name"], spotify_id: user_params["id"], href: user_params["href"], uri: user_params["uri"], followers: user_params["followers"]["total"], image_url: nil, access_token: auth_params["access_token"], refresh_token: auth_params["refresh_token"])
        image = user_params["images"][0] ? user_params["images"][0]["url"] : nil
        user.image_url = image
        user.save
        redirect_to "http://localhost:3001/users/#{user.id}"
    end
  end



  def update
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
  end


  def getMyPlaylists
    playlists = User.find_by(id: params[:id]).playlists
    render json: playlists
  end

  private

  def user_params
  end
end