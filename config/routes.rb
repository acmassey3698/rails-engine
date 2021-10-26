Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :destroy]
      get '/merchants/:id/items', to: 'merchant_items#index', as: "merchant_items"
    end
  end
end
