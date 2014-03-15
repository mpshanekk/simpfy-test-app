class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @artist = Artist.find(params[:artist_id])
  end

  def show
  end

  def new
    @artist = Artist.find(params[:artist_id])
    @albums = @artist.albums.new
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
        format.json { render json: @artist.albums.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @artist = Artist.find(params[:artist_id])
    respond_to do |format|
      if @artist.albums.update_attributes(album_params)
        format.html { redirect_to artist_path(@artist), notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @artist.albums.errors, status: :unprocessable_entity }
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
      params.require(:album).permit(:title, :genre)
    end
end
