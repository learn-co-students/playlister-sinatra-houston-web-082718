class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end
  # ---------------------------------------------------------
  get '/songs' do 
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/:slug' do
    params[:slug] = unslug(params[:slug])
    @song = Song.find_by(:name => params[:slug])
    erb :'songs/show'
  end
  # ---------------------------------------------------------
  get '/artists' do
    @artists = Artist.all
    erb :'artists/index'
  end

  get '/artists/:slug' do
    params[:slug] = unslug(params[:slug])
    @artist = Artist.find_by(:name => params[:slug])
    erb :'artists/show'
  end
# ---------------------------------------------------------
  get '/genres' do
    @genres = Genre.all
    erb :'genres/index'
  end

  get '/genres/:slug' do
    params[:slug] = unslug(params[:slug])
    @genre = Genre.find_by(:name => params[:slug])
    erb :'genres/show'
  end
  # ---------------------------------------------------------



  

  def unslug(string)
    name_string = ""
    string.split("-").each do |word|
      name_string.concat(word.capitalize)
      name_string.concat(" ")
    end
    name_string.strip
  end
end