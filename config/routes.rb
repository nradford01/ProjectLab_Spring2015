Rails.application.routes.draw do
  
  get 'users/profile', to: 'users#profile', as: :profile
  get 'users/index', to: 'users#index', as: :index

  devise_for :users, :controllers => { registrations: 'registrations' }
   
  resources :users, only: [:show]
    
  root 'static_pages#home'

  get '/about', to: 'static_pages#about', as: :about
  get '/contact', to: 'static_pages#contact', as: :contact

  resources :projects 
  
end
