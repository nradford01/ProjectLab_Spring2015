Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'sessions'
      }
  root 'static_pages#home'

  get '/about', to: 'static_pages#about', as: :about
  get '/contact', to: 'static_pages#contact', as: :contact

  resources :projects 
  
end
