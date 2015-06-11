Rails.application.routes.draw do
  resources :articles
  root 'home#index'
  get ':number' => 'home#show', as: :blog
end
