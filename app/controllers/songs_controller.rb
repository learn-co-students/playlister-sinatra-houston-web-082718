class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end


  get '/songs/new' do
    @genres = Genre.all
    erb :'songs/new'
  end

  post '/songs' do

    @song = Song.create(name: params[:name], artist: Artist.find_or_create_by(name: params[:artist]), genre_ids: params[:genre_ids])
    redirect "/songs/#{@song.id}"
  end

  get '/songs/:id' do
    @song = Song.find(params[:id])
    erb :'songs/show'
  end

  get '/songs/:id/edit' do
    @song = Song.find(params[:id])
    @genres =Genre.all
    erb :'songs/edit'
  end

  patch '/songs/:id' do
    @song = Song.find(params[:id])
    @song.update(name: params[:name], artist: Artist.find_or_create_by(name: params[:artist]), genre_ids: params[:genre_ids])
    redirect "/songs/{#@song.id}"
  end

end