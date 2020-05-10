Rails.application.routes.draw do
  root to: 'users#index'
  resources :users, only: :index
  resources :csv_exports, only: %i[create index show]
end
