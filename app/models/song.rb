class Song < ActiveRecord::Base
    belongs_to :artist
    belongs_to :genres
    # has_many :genres, through: :song_genres
end