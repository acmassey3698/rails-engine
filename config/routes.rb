Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :most_items, only: :index
      end
      namespace :revenue do
        resources :merchants, only:[:index, :show]
        resources :items, only: :index
      end
      get '/merchants/find', to: 'merchants#find'
      get '/items/find_all', to: 'items#find_all'
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :destroy, :update]
      get '/merchants/:id/items', to: 'merchant_items#index'
      get '/items/:id/merchant', to: 'items_merchant#show'
    end
  end
end
