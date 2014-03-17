require 'spec_helper'

describe AlbumsController do

  let(:valid_attributes) { { "title" => "MyString","genre" => "pop"} }
  let(:artist_attributes) { { "name" => "MyString","gender" => Artist::GENDER.sample } }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all albums as @albums" do
     artist = Artist.create! artist_attributes
     album = artist.albums.create! valid_attributes
     get :index, {:artist_id => artist.id}, valid_session
     assigns(:albums).should eq([album])
    end
  end

  describe "GET show" do
    it "assigns the requested album as @album" do
      artist = Artist.create! artist_attributes
      album = Artist.find(artist.id).albums.create! valid_attributes
      get :show, {:artist_id => artist.id, :id => album.to_param}, valid_session
      assigns(:album).should eq(album)
    end
  end

  describe "GET new" do
    it "assigns a new album as @album" do
      artist = Artist.create! artist_attributes
      get :new, {:artist_id => artist.id}, valid_session
      assigns(:album).should be_a_new(Album)
    end
  end

  describe "GET edit" do
    it "assigns the requested album as @album" do
      artist = Artist.create! artist_attributes
      album = Artist.find(artist.id).albums.create! valid_attributes
      get :edit, {:artist_id => artist.id, :id => album.to_param}, valid_session
      assigns(:album).should eq(album)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Album" do
       artist = Artist.create! artist_attributes
        expect {
          post :create, {:artist_id => artist.id, :album => valid_attributes}, valid_session
        }.to change(Album, :count).by(1)
      end

      it "assigns a newly created album as @album" do
        artist = Artist.create! artist_attributes
        post :create, {:artist_id => artist.id, :album => valid_attributes}, valid_session
        assigns(:album).should be_a(Album)
        assigns(:album).should be_persisted
      end

      it "redirects to the created album" do
        artist = Artist.create! artist_attributes
        album = Artist.find(artist.id).albums
        post :create, {:artist_id => artist.id, :album => valid_attributes}, valid_session
        response.should redirect_to(artist_path(artist))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved album as @album" do
        artist = Artist.create! artist_attributes
        Album.any_instance.stub(:save).and_return(false)
        post :create, {:artist_id => artist.id, :album => { "title" => "invalid value" }}, valid_session
        assigns(:album).should be_a_new(Album)
      end

      it "re-renders the 'new' template" do
        artist = Artist.create! artist_attributes
        Album.any_instance.stub(:save).and_return(false)
        post :create, {:artist_id => artist.id, :album => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested album" do
        artist = Artist.create! artist_attributes
        album = Artist.find(artist.id).albums.create! valid_attributes
        Album.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, {:artist_id => artist.id, :id => album.to_param, :album => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested album as @album" do
        artist = Artist.create! artist_attributes
        album = Artist.find(artist.id).albums.create! valid_attributes
        put :update, {:artist_id => artist.id, :id => album.to_param, :album => valid_attributes}, valid_session
        assigns(:album).should eq(album)
      end

      it "redirects to the album" do
        artist = Artist.create! artist_attributes
        album = Artist.find(artist.id).albums.create! valid_attributes
        put :update, {:artist_id => artist.id, :id => album.to_param, :album => valid_attributes}, valid_session
        response.should redirect_to(artist_album_path(artist,album))
      end
    end

    describe "with invalid params" do
      it "assigns the album as @album" do
        artist = Artist.create! artist_attributes
        album = Artist.find(artist.id).albums.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        put :update, {:artist_id => artist.id,:id => album.to_param, :album => { "title" => "invalid value" }}, valid_session
        assigns(:album).should eq(album)
      end

      it "re-renders the 'edit' template" do
        artist = Artist.create! artist_attributes
        album = Artist.find(artist.id).albums.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        put :update, {:artist_id => artist.id, :id => album.to_param, :album => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested album" do
      artist = Artist.create! artist_attributes
      album = Artist.find(artist.id).albums.create! valid_attributes
      expect {
        delete :destroy, {:artist_id => artist.id, :id => album.to_param}, valid_session
      }.to change(Album, :count).by(-1)
    end

    it "redirects to the albums list" do
      artist = Artist.create! artist_attributes
      album = Artist.find(artist.id).albums.create! valid_attributes
      delete :destroy, {:artist_id => artist.id,:id => album.to_param}, valid_session
      response.should redirect_to(artist_path(artist))
    end
  end

end
