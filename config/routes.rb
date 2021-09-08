Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end

      resources :items, only: [:index, :show, :create, :update, :destroy]

      # get '/api/v1/revenue/merchants', to:
      # get '/api/vi/items/find', to: 
      # get '/api/vi/items/find_all', to: 
      # get '/api/vi/merchants/find', to: 
      # get '/api/vi/merchants/find_all', to: 
      
    end
  end
end
