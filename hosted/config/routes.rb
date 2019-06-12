Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :inboxes, only: [:show]
  resources :inbound_messages, only: [:create, :show]

  root "home#show"
end
