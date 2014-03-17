CdManagementApp::Application.routes.draw do

  resources :artists do 
  	resources :albums do
  	 resources :tracks
    end
  end
  #get 'albums' => 'albums#list_albums' 
  match 'albums', to: 'albums#list_albums', via: 'get'
  
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}, :path => "auth"
  resources :users
end