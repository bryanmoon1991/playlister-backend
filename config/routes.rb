Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/login', to: "auth#spotify_request"
      get '/user', to: "users#create"
      patch '/user', to: "users#update"
      resources :users
    end
  end
end
