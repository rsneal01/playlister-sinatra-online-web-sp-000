
class SongsController < ApplicationController
    get '/songs' do
        # binding.pry
        erb :'/songs/index'
    end
end
