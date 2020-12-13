require 'rest_client'
require 'JSON'
# require 'dotenv'
# Dotenv.load('./.env')
# require 'dotenv/load'

class User < ApplicationRecord
    
    
  def access_token_expired?
    (Time.now - self.updated_at) > 3300 
  end

  def refresh_access_token
    body = {
      grant_type: 'refresh_token',
      refresh_token: self.refresh_token,
      client_id: ENV['CLIENT_ID'], 
      client_secret: ENV['CLIENT_SECRET'] 
    }
    auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
    auth_params = JSON.parse(auth_response)
    self.update(access_token: auth_params["access_token"])
  end
end
