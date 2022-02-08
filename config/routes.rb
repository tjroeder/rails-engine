Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, only: %i[index show] do
        resources :items, controller: :merchant_items, only: [:index]
      end
      resources :items, only: %i[index show] do
        resources :merchant, controller: :items_merchant, only: [:index]
      end
    end
  end
end
