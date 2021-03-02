class SongGenre < ActiveRecord::Base
    belongs_to :artist
    belongs_to :genres
    belongs_to :songs
end