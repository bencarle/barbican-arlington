Rails.application.routes.draw do
  resources :targets, only: [:index, :create]
end
