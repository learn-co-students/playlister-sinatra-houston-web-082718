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
  @new_song = Song.create(name:params[:song_name], artist_id:Artist.find_or_create_by(name:params[:artist_name]).id)
  SongGenre.create(song_id:@new_song.id, genre_id:Genre.find_by(name:params[:genre_name]).id)
  redirect '/songs'
end

get '/songs/:slug' do
  @song = Song.find_by_slug(params[:slug])
  @song_genre = SongGenre.find_by(song_id:@song.id)
  erb :'songs/show'
end

get '/songs/:slug/edit' do
  @song = Song.find_by_slug(params[:slug])
  @genres = Genre.all.uniq
  erb :'songs/edit'
end

patch '/songs/:slug' do
  @song = Song.find_by_slug(params[:slug])
  @song.update(name:params[:song_name],artist_id:Artist.find_or_create_by(name:params[:artist_name]).id)
  @song_genre = SongGenre.find_by(song_id:@song.id)
  @song_genre.update(genre_id:Genre.find_by(name:params[:genre_name]).id)
  @song.save
  @song_genre.save
  redirect '/songs'
end

end
