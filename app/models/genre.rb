class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs
    

    def slug
        @slug = self.name.parameterize
        @slug
    end

    def self.find_by_slug(slug)
        @genre = Genre.all.find do |genre|
            genre.slug == slug
        end
        @genre     
    end

end