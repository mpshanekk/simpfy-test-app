CdManagementApp::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}, :path => "auth"
  resources :users
end