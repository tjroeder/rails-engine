Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, only: %i[index show] do
        scope module: :merchants do
          resources :items, only: [:index]
        end
      end

      resources :items do
        scope module: :items do
          resources :merchant, only: [:index]
        end
      end
    end
  end
end
