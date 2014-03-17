class HomeController < ApplicationController

def index
  if params[:search]
     @albums = Album.search(params[:search]).order("created_at DESC")
     @artists = Artist.search(params[:search]).order("created_at DESC")
  else
     @artists = Artist.all
     @albums = Album.all
   end
end
end
