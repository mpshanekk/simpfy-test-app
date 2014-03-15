class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]

  def index
    @artist = Artist.find(params[:artist_id])
    @album =  @artist.albums.find(params[:album_id])
  end

  def show
  end

  def new
    @artist = Artist.find(params[:artist_id])
    @album =  @artist.albums.find(params[:album_id]) 
    @track =  @album.tracks.new
  end

  def edit
  end

   def create
    @artist = Artist.find(params[:artist_id])
    @album =  @artist.albums.find(params[:album_id]) 
    @track =  @album.tracks.create(track_params)
    respond_to do |format|
      if @track.save
        format.html { redirect_to artist_album_path(@album.artist_id,@album), notice: 'Track was successfully created.' }
        format.json { render action: 'show', status: :created, location: @track }
      else
        format.html { render action: 'new' }
        format.json { render json: artist_album_path(@album.artist_id,@album).errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @artist = Artist.find(params[:artist_id])
    @album =  @artist.albums.find(params[:album_id]) 
    respond_to do |format|
      if @album.tracks.update(track_params)
        format.html { redirect_to artist_album_path(@artist,@album), notice: 'Track was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @album.tracks.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @artist = Artist.find(params[:artist_id])
    @album =  @artist.albums.find(params[:album_id]) 
    @track =  @album.tracks.find(params[:id])
    @track.destroy
    redirect_to artist_album_path(@artist,@album)
  end

  private
    def set_track
     @artist = Artist.find(params[:artist_id])
     @album =  @artist.albums.find(params[:album_id])
     @track = @album.tracks.find(params[:id])
    end

    def track_params
      params.require(:track).permit(:name, :length, :album_id)
    end
end
