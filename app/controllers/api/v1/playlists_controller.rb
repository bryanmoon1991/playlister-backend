class Api::V1::PlaylistsController < ApplicationController

   
    def create 
        playlist = Playlist.create(playlist_params)
        if playlist.valid?
            render json: playlist
        end
    end

    def update
        playlist = Playlist.find(params[:id])
        playlist.update(playlist_params)
        render json: playlist
    end


    private

    def playlist_params
       params.require(:playlist).permit(:user_id, :name, :private, :description, :href, :spotify_id, :images, :items, :uri) 
    end
end
