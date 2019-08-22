Rails.application.routes.draw do
  root 'buildings#index'

  resources :buildings
end
