
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
                @genre= Genre.find_by(name: genre)
                @song.genres << @genre
            end
        
        else 
            @song = Song.create(name: params[:song][:name])
            @artist = Artist.all.find_by(name: params[:artist][:name])
            @artist.songs << @song
            params[:genre].each do |genre|
                @genre= Genre.find_by(name: genre)
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
        # binding.pry
        # @song.update(params[:artist])
        # @artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.genre_ids = params[:genres]
        @song.save
        
        flash[:message] = "Successfully updated song."
        redirect to("/songs/#{@song.slug}")
    end



end
