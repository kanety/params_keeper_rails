Rails.application.routes.draw do
  root to: "application#index"
  resources :application, only: [:index]
  resources :samples
  resources :others1
  resources :others2
end
