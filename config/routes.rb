Rails.application.routes.draw do
  mount Mercury::Engine => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :api do
    concern :api_base do
      resources :templates do
        resources :documents, only: [ :create ]
      end
    end

    namespace :v1 do
      concerns :api_base
    end
  end

  apipie

  resources :templates

  mount EgovUtils::Engine => '/internals'
end
