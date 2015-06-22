Rails.application.routes.draw do
  resources :articles
  root 'home#index'
  get 'results' => 'home#results', as: :results
  get ':number' => 'home#show', as: :blog
  get 'categories/:title' => 'categories#show', as: :category
end
