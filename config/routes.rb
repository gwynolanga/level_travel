Rails.application.routes.draw do
  root 'buildings#index'

  resources :buildings, except: %i[new show]
end
