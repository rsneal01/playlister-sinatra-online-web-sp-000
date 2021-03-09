
class SongsController < ApplicationController
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
        
        if !params[:artist].empty? && params[:artist][:name] != ""
            @artist = Artist.create(name: params[:artist][:name])
            @song = Song.create(name: params[:song][:name], artist: params[:artist_id])
            @artist.songs << @song
          end
          
          
          redirect to "songs/#{@song.slug}"
    end



end
