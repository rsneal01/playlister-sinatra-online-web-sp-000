class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :songs

    def slug
        @slug = self.name.parameterize
        @slug
    end

    def self.find_by_slug(slug)
        @artist = Artist.all.find do |artist|
            artist.slug == slug
        end
        @artist     
    end

        
  


end
