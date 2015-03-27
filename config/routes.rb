Rails.application.routes.draw do
  # get 'tasks/new'

  # get 'tasks/edit'

  # get 'tasks/create'

  # get 'tasks/update'

  # get 'tasks/destroy'

  root 'static_pages#home'

  get '/about', to: 'static_pages#about', as: :about
  get '/contact', to: 'static_pages#contact', as: :contact

  resources :projects do
   resources :tasks, except: [:index, :show]
end 
  
end
