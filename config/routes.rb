Rails.application.routes.draw do
  resources :events, only: %i[new create show edit update destroy] do
    resources :tickets, only: %i[new create destroy]
  end

  resource :retirements, only: %i[new create]

  #get 'welcome/index'
  root "welcome#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/auth/:provider/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  get "status" => 'status#index', defaults: { format: 'json' }

  match "*path" => "application#error404", via: :all
end
