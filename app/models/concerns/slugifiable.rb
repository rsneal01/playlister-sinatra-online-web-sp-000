class Slugify

    def slug(str)
        str.ljust(100).strip.gsub(/[\s\t\r\n\f]/,'_').gsub(/\W/,'').downcase
    end

end
