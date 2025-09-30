Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :users, only: [:index] # To easily find other users

  resources :chats, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end

  # Custom route to initiate a chat from the User's profile/listing
  post 'chats/start/:user_id', to: 'chats#create', as: 'start_chat'

end
