class Song < ActiveRecord::Base
    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres

    def slug
        @slug = self.name.parameterize
        @slug
    end

    def self.find_by_slug(slug)
        @song = Song.all.find do |song|
            song.slug == slug
        end
        @song     
    end

end