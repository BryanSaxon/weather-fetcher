Rails.application.routes.draw do
  root "postal_codes#index"

  resources :forecasts, only: %i[show]
  resources :postal_codes, only: %i[index create]
end
