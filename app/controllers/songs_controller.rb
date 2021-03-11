
require 'rack-flash'


class SongsController < ApplicationController
    use Rack::Flash
    enable :sessions
    
    get '/songs' do
        @songs = Song.all
        # binding.pry
        erb :'/songs/index'
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'/songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end

    post '/songs' do
        # how do we check to see if there is an existing artist?
        # binding.pry
        if !params[:artist].empty? && params[:artist][:name] != "" 
            @artist = Artist.create(name: params[:artist][:name])
            @song = Song.create(name: params[:song][:name], artist: params[:artist_id])
            @artist.songs << @song
            params[:genre].each do |genre|
                @genre= Genre.create(name: genre)
                @song.genres << @genre
            end
        elsif params[:artist][:name] == Artist.all.find_by(name: params[:artist][:name]).name
            @song = Song.create(name: params[:song][:name], artist: params[:artist_id])
            @artist = Artist.all.find_by(name: params[:artist][:name])
            @artist.songs << @song
        end
        # && params[:artist][:name] != Artist.all.find_by(name: params[:artist][:name]).name
          flash[:message] = "Successfully created song."
          
          redirect to("/songs/#{@song.slug}")
    end

end
