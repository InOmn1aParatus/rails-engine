Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/search#show'
      get '/merchants/find_all', to: 'merchants/search#index'

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
      
      get '/items/find', to: 'items/search#show'
      get '/items/find_all', to: 'items/search#index'
      
      resources :items do
        get '/merchant', to: 'merchant#show'
      end


      # get '/api/v1/revenue/merchants', to:
      
    end
  end
end
