Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :destroy, :update]
      get '/merchants/:id/items', to: 'merchant_items#index', as: "merchant_items"
      get '/items/:id/merchant', to: 'items_merchant#show', as: "items_merchant"
    end
  end
end
