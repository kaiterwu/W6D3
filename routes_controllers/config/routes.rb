Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, except:[:new, :edit] do 
    resources :artworks, only: [:index]
  end
  resources :artworks, except:[:new, :edit, :index] 
  resources :artwork_shares, only:[:create,:destroy]
  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show', as: 'user'
  # patch '/users/:id', to: 'users#update'
  # put '/users/:id', to: 'users#update'
  # post '/users', to: 'users#create'
  # delete '/users/:id', to: 'users#destroy'
  # get '/users/new(.:format)', to: 'users#new'
  # get '/users/:id/edit(.:format)', to: 'users#edit'

  # Defines the root path route ("/")
  # root "articles#index"
end
