CdManagementApp::Application.routes.draw do

  resources :artists do 
  	resources :albums do
  		  resources :tracks
    end
  end


  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}, :path => "auth"
  resources :users
end