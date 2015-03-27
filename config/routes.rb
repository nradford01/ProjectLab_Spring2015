Rails.application.routes.draw do
	
	root 'static_pages#home'
  
  devise_for :users, :controllers => { registrations: 'registrations' }
   
  resources :users, only: [:show, :index]
  get 'profile', to: 'users#profile', as: :profile

  get '/about', to: 'static_pages#about', as: :about
  get '/contact', to: 'static_pages#contact', as: :contact

  resources :projects   
end
