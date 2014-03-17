require 'spec_helper'

describe TracksController do

  let(:valid_attributes) { { "name" => "MyString","length" => 5 } }
  let(:album_attributes) { { "title" => "MyString", "genre" => "pop" } }
  let(:artist_attributes) { { "name" => "MyString","gender" => Artist::GENDER.sample } }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all tracks as @tracks" do
      artist = Artist.create! artist_attributes
      album = artist.albums.create! album_attributes
      track = album.tracks.create! valid_attributes
      get :index, {:artist_id => artist.id,:album_id => album.id}, valid_session
      assigns(:tracks).should eq([track])
    end
  end
 
  describe "GET show" do
    it "assigns the requested track as @track" do
      artist = Artist.create! artist_attributes
      album = artist.albums.create! album_attributes
      track = album.tracks.create! valid_attributes
      get :show, {:artist_id => artist.id,:album_id => album.id,:id => track.to_param}, valid_session
      assigns(:track).should eq(track)
    end
  end

  describe "GET new" do
    it "assigns a new track as @track" do
      artist = Artist.create! artist_attributes
      album = artist.albums.create! album_attributes
      get :new, {:artist_id => artist.id,:album_id => album.id}, valid_session
      assigns(:track).should be_a_new(Track)
    end
  end

  describe "GET edit" do
    it "assigns the requested track as @track" do
      artist = Artist.create! artist_attributes
      album = artist.albums.create! album_attributes
      track = album.tracks.create! valid_attributes
      get :edit, {:artist_id => artist.id,:album_id => album.id,:id => track.to_param}, valid_session
      assigns(:track).should eq(track)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Track" do
        artist = Artist.create! artist_attributes
        album = artist.albums.create! album_attributes
        expect {
          post :create, {:artist_id => artist.id,:album_id => album.id,:track => valid_attributes}, valid_session
        }.to change(Track, :count).by(1)
      end

      it "assigns a newly created track as @track" do
        artist = Artist.create! artist_attributes
        album = artist.albums.create! album_attributes
        post :create, {:artist_id => artist.id,:album_id => album.id,:track => valid_attributes}, valid_session
        assigns(:track).should be_a(Track)
        assigns(:track).should be_persisted
      end

      it "redirects to the created track" do
        artist = Artist.create! artist_attributes
        album = artist.albums.create! album_attributes
        post :create, {:artist_id => artist.id,:album_id => album.id,:track => valid_attributes}, valid_session
        response.should redirect_to(artist_album_path(artist,album))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved track as @track" do
        artist = Artist.create! artist_attributes
        album = artist.albums.create! album_attributes
        Track.any_instance.stub(:save).and_return(false)
        post :create, {:artist_id => artist.id,:album_id => album.id,:track => { "name" => "invalid value" }}, valid_session
        assigns(:track).should be_a_new(Track)
      end

      it "re-renders the 'new' template" do
        artist = Artist.create! artist_attributes
        album = artist.albums.create! album_attributes
        Track.any_instance.stub(:save).and_return(false)
        post :create, {:artist_id => artist.id,:album_id => album.id,:track => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested track" do
  #       artist = Artist.create! artist_attributes
  #       album = artist.albums.create! album_attributes
  #       track = album.tracks.create! valid_attributes
  #       Track.any_instance.should_receive(:update).with({ "name" => "MyString","length" => 5 })
  #       put :update, {:artist_id => artist.id,:album_id => album.id,:id => track.to_param, :track => { "name" => "MyString","length" => 5 }}, valid_session
  #     end

  #     it "assigns the requested track as @track" do
  #       artist = Artist.create! artist_attributes
  #       album = artist.albums.create! album_attributes
  #       track = album.tracks.create! valid_attributes
  #       put :update, {:artist_id => artist.id,:album_id => album.id,:id => track.to_param, :track => valid_attributes}, valid_session
  #       assigns(:track).should eq(track)
  #     end

  #     it "redirects to the track" do
  #       artist = Artist.create! artist_attributes
  #       album = artist.albums.create! album_attributes
  #       track = album.tracks.create! valid_attributes
  #       put :update, {:artist_id => artist.id,:album_id => album.id,:id => track.to_param, :track => valid_attributes}, valid_session
  #       response.should redirect_to(track)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the track as @track" do
  #       track = Track.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Track.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => track.to_param, :track => { "name" => "invalid value" }}, valid_session
  #       assigns(:track).should eq(track)
  #     end

  #     it "re-renders the 'edit' template" do
  #       track = Track.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Track.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => track.to_param, :track => { "name" => "invalid value" }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  describe "DELETE destroy" do
    it "destroys the requested track" do
      artist = Artist.create! artist_attributes
      album = artist.albums.create! album_attributes
      track = album.tracks.create! valid_attributes
      expect {
        delete :destroy, {:artist_id => artist.id,:album_id => album.id,:id => track.to_param}, valid_session
      }.to change(Track, :count).by(-1)
    end

    it "redirects to the tracks list" do
      artist = Artist.create! artist_attributes
      album = artist.albums.create! album_attributes
      track = album.tracks.create! valid_attributes
      delete :destroy, {:artist_id => artist.id,:album_id => album.id,:id => track.to_param}, valid_session
      response.should redirect_to(artist_album_url(artist,album))
    end
  end

end
