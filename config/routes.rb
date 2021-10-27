Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      get '/items/find_all', to: 'items#find_all'
      get '/revenue/merchants/:id', to: 'revenue#show'
      get '/revenue/merchants', to: 'revenue#top_merchants'
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :destroy, :update]
      get '/merchants/:id/items', to: 'merchant_items#index', as: "merchant_items"
      get '/items/:id/merchant', to: 'items_merchant#show', as: "items_merchant"
    end
  end
end
