class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres

    has_many :artists, through: :songs

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
                name
            end
            join_name = upcase_name.join(' ')
        else
            join_name = slug
        end

        genre = Genre.find_by(name: join_name)
    end
end