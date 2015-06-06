Rails.application.routes.draw do
  root to: "urls#new"
  resources :urls
  devise_for :users, controllers: { registrations: "users/registrations" }
end
