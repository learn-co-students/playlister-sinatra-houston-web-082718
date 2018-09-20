class ArtistsController < ApplicationController

    get '/artists' do
        @artists = Artist.all
        erb :'/artists/index'
    end

    get '/artists/:slug' do
        @artist = nil
        slug = params[:slug]

        if slug.include?('-')
            @artist = Artist.find_by_slug(slug)
        else
            new_slug = slug.gsub(' ','-')
            @artist = Artist.find_by_slug(new_slug)
        end
        @songs = @artist.songs
        @genres = @artist.genres
        erb :'/artists/show'
    end

end
