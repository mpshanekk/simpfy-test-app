class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]

  # GET /tracks
  # GET /tracks.json
  def index
    @album =  Album.find(params[:album_id])
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks
  # POST /tracks.json
  def create
    @album =  Album.find(params[:album_id])
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

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update
    @album =  Album.find(params[:album_id])
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

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @album =  Album.find(params[:album_id])
    @track =  @album.tracks.find(params[:id])
    @track.destroy
    redirect_to artist_album_path(@artist,@album)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
     @artist = Artist.find(params[:artist_id])
     @album =  @artist.albums.find(params[:album_id])
     @track = @album.tracks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params.require(:track).permit(:name, :length, :album_id)
    end
end
