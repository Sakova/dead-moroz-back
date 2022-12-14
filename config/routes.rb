require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  mount Sidekiq::Web => '/sidekiq'

  get "/member-data", to: "members#index"

  namespace :api do
    namespace :v1 do
      resources :addresses, only: %i[create]
      resources :gifts, only: %i[index create update destroy] do
        get "page/:page", action: :index, on: :collection
      end
      resources :assessments, only: %i[create update]
      resources :feedbacks, only: %i[create update]
      get "users/page/:page", to: "users#index"
      get "users/:user", to: "users#translate"
    end
  end
end
