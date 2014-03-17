class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @artist = Artist.find(params[:artist_id])
     if params[:search]
      @albums = Album.search(params[:search]).order("created_at DESC")
    else
      @albums = @artist.albums
    end
  end

  def list_albums
     if params[:search]
      @albums = Album.search(params[:search]).order("created_at DESC")
     else
      @albums = Album.all.order("updated_at DESC")
     end
  end

  def show
  end

  def new
    @artist = Artist.find(params[:artist_id])
    @album = @artist.albums.new
  end

  def edit
  end

  def create
    @artist = Artist.find(params[:artist_id])
    @album =  @artist.albums.create(album_params)
    respond_to do |format|
      if @album.save
        format.html { redirect_to artist_path(@artist), notice: 'Album was successfully created.' }
        format.json { render action: 'show', status: :created, location: @album }
      else
        format.html { render action: 'new' }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @artist = Artist.find(params[:artist_id])
    @album =  @artist.albums.find(params[:id])
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to artist_album_path(@artist,@album), notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @artist = Artist.find(params[:artist_id])
    @album =  @artist.albums.find(params[:id])
    @album.destroy
    redirect_to artist_path(@artist)
  end

  private
    def set_album
     @artist = Artist.find(params[:artist_id])
     @album =  @artist.albums.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:title, :genre,:cover)
    end
end
