class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    @artist = Artist.find(params[:artist_id])
    #@albums = @artist.albums
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    #@album = Album.new
    @artist = Artist.find(params[:artist_id])
    @albums = @artist.albums.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
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

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
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

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @artist = Artist.find(params[:artist_id])
    @album =  @artist.albums.find(params[:id])
    @album.destroy
    redirect_to artist_path(@artist)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
     @artist = Artist.find(params[:artist_id])
     @album =  @artist.albums.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :genre)
    end
end
