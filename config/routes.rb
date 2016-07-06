Rails.application.routes.draw do
  root 'home#index'

  get 'dashboard' => 'dashboard#index'

  # Token routes
  post 'token/generate' => 'token#generate'

  # Twilio routes
  post 'call/connect' => 'call#connect'
  post 'call/voicemail' => 'call#voicemail'

  # Slack routes
  post 'slack/handle-call' => 'slack#handle_record'
  post 'slack/handle-record' => 'slack#handle_record'

  # Contact routes
  post 'contact/create' => 'contact#create'

  resources :tickets, only: [:create]
end
