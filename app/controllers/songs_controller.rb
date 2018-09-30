require 'pry'
class SongsController < ApplicationController
    
    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end
    
    get '/songs/new' do
        @genres = Genre.all.uniq
        erb :'songs/new'
    end
    
    post '/songs' do
        song = Song.create(name: params[:song_name], artist_id: Artist.find_or_create_by(name: params[:artist_name]).id)

        params[:genre_name].each do |genre_name|
            SongGenre.create(song_id: song.id, genre_id: Genre.find_by(name: genre_name).id)
        end
        
        redirect "/songs/#{song.slug}"
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all.uniq
        erb :'songs/edit'
    end

    patch '/songs/:slug' do
        song = Song.find_by_slug(params[:slug])
        song.update(name: params[:song_name], artist_id: Artist.find_or_create_by(name: params[:artist_name]).id)
        song.save

        params[:genre_name].each do |genre_name|
            if !(SongGenre.find_by(song_id: song.id, genre_id: Genre.find_by(name: genre_name).id))
                SongGenre.create(song_id: song.id, genre_id: Genre.find_by(name: genre_name).id)
            end
        end
        
        redirect "/songs/#{song.slug}"
    end

end