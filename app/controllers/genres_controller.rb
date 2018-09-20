class GenresController < ApplicationController

    get '/genres' do
        @genres = Genre.all
        erb :'/genres/index'
    end

    get '/genres/:slug' do
        @genres = nil
        slug = params[:slug]

        if slug.include?('-')
            @genres = Genre.find_by_slug(slug)
        else
            new_slug = slug.gsub(' ','-')
            @genres = Genre.find_by_slug(new_slug)
        end
        @artists = @genres.artists
        @songs = @genres.songs
        erb :'/genres/show'
    end

end