Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, only: %i[index show] do
        scope module: :merchants do
          resources :items, only: [:index]
          get 'find', to: 'search#find', on: :collection
          get 'most_items', on: :collection
        end
      end

      resources :items do
        scope module: :items do
          resources :merchant, only: [:index]
          get 'find_all', to: 'search#find_all', on: :collection
        end
      end

      namespace :revenue do
        resources :merchants, only: [:index]
        resources :items, only: [:index]
      end

      resources :revenue, only: [:index]
    end
  end
end
