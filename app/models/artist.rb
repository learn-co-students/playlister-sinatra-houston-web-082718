class Artist < ActiveRecord::Base

    has_many :songs
    has_many :genres

    has_many :genres, through: :songs

    def slug
        s = nil
        if self.name.downcase.include?(' ')
            s = self.name.downcase
            s.gsub!(' ','-')
        else
            s = self.name.downcase
        end
    end

    def self.find_by_slug(slug)
        join_name = nil
        if slug.include?('-')
            s = slug.gsub!('-',' ')
            song_name = s.split(' ')
            upcase_name = song_name.map do |name|
                name.capitalize
            end
            join_name = upcase_name.join(' ')
        else
            join_name = slug.capitalize
        end

        artist = Artist.find_by(name: join_name)
    end

end