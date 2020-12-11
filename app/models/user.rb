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
    # if access_token_expired?
      body = {
        grant_type: 'refresh_token',
        refresh_token: self.refresh_token,
        client_id: ENV['CLIENT_ID'], 
        client_secret: ENV['CLIENT_SECRET'] 
      }
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response)
      self.update(access_token: auth_params["access_token"])
    # else
      # puts "Current Token Has Not Expired"
    # end
  end
end
