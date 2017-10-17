Rails.application.routes.draw do
  resources :clients, only: :index
  resources :invoices, only: [:show, :index]
end
