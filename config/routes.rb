Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/login", to: "sessions#login"
  post "/graphql", to: "graphql#execute"
  resources :users, only: [:create]

  resources :store1s, only: [:index, :create] do
    resources :products, only: [:index, :show, :create, :update, :destroy]
  end
  
  
  get "up" => "rails/health#show", as: :rails_health_check
end