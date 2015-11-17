Rails.application.routes.draw do
  # errors
  match '/422', to: 'application#server_error', via: :all
  match '/500', to: 'application#server_error', via: :all
  match '/404', to: 'application#routing_error', via: :all

  resources :articles
  root 'home#index'
  # get 'results' => 'home#results', as: :results
  get ':permalink' => 'home#show', as: :blog
  get 'categories/:title' => 'categories#show', as: :category

  match '*path', to: 'application#routing_error', via: :all
end
