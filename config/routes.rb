Rails.application.routes.draw do
  
  get 'users/profile', to: 'users#profile', as: :profile

  resources :users

  devise_for :users, :controllers => { registrations: 'registrations' }
      
  root 'static_pages#home'

  get '/about', to: 'static_pages#about', as: :about
  get '/contact', to: 'static_pages#contact', as: :contact

  resources :projects 
  
end
