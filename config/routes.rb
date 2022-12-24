Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  get "/member-data", to: "members#index"

  namespace :api do
    namespace :v1 do
      resources :addresses, only: %i[create]
      resources :gifts, only: %i[index create update destroy] do
        get 'page/:page', action: :index, on: :collection
      end
    end
  end
end
