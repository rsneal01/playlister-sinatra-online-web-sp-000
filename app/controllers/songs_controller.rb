
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
        # check if there is existing artist
        # if not create a new artist and new song with fqorm info
        # redirect
        # compare params[:artist][:name] with Artist.all.find_by(name: params[:artist][:name]).name collection to see if there is a match
        # binding.pry

        if Artist.all.find_by(name: params[:artist][:name]) == nil
            @artist = Artist.create(name: params[:artist][:name])
            @song = Song.create(name: params[:song][:name])
            @artist.songs << @song
            params[:genre].each do |genre|
                @genre= Genre.create(name: genre)
                @song.genres << @genre
            end
        
        else 
            @song = Song.create(name: params[:song][:name])
            @artist = Artist.all.find_by(name: params[:artist][:name])
            @artist.songs << @song
            params[:genre].each do |genre|
                @genre= Genre.create(name: genre)
                @song.genres << @genre
            end
        end
          flash[:message] = "Successfully created song."
          
          redirect to("/songs/#{@song.slug}")
    end


    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :'/songs/edit'
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.artist.update(params[:artist])
        binding.pry
        # Want to be able to call @song.genres.update(params[:genre]), and update the song's genre using data from Edit form checkbox
        # Why aren't we getting a genre key/value in our params?
        flash[:message] = "Successfully updated song."
        redirect to("/songs/#{@song.slug}")
    end



end
