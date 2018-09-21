class SongsController < ApplicationController

    get '/songs' do
        @songs = Song.all
        erb :'/songs/index'
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'/songs/new'
    end

    post '/songs' do 
        song_name = params[:song][:name]
        new_name = song_name.split(' ')
        new_name.map do |i|
            i.capitalize
        end
        song_name = new_name.join(' ')
        artist = Artist.find_or_create_by(name: params[:song][:artist])
        new_song = Song.create(name: song_name)
        # new_song.artist = artist
        new_song.update(artist: artist)
        genre_array = params[:song][:genre]
        genre_array.each do |genre|
            genre_instance = Genre.find_by(name: genre)
            SongGenre.create(song_id: new_song.id, genre_id: genre_instance.id)
        end
        flash[:message] = "Successfully created song."
        redirect '/songs'
    end

    get '/songs/:slug' do
        @song = nil
        slug = params[:slug]

        if slug.include?('-')
            @song = Song.find_by_slug(slug)
        else
            new_slug = slug.gsub(' ','-')
            @song = Song.find_by_slug(new_slug)
        end
        @artist = @song.artist
        @genres = @song.genres
        erb :'/songs/show'
    end

    get '/songs/:slug/edit' do 
        slug = params[:slug]
        @genres= Genre.all
        @song = Song.find_by_slug(slug)
        erb :'/songs/edit'
    end

    patch '/songs/:slug' do 
        song = Song.find_by_slug(params[:slug])
        genres = SongGenre.where(song_id: song.id)
        genres.each do |genre|
            genre.destroy
        end
        params[:song][:genre].each do |genre|
            genre_instance = Genre.find_by(name: genre)
            SongGenre.create(song_id: song.id, genre_id: genre_instance.id)
        end
        artist = Artist.find_or_create_by(name: params[:song][:artist])
        song.update(artist_id: artist.id)
        flash[:message] = "Successfully created song."
        redirect "/songs/#{song.slug}"
    end

end
