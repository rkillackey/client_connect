Rails.application.routes.draw do
  root 'dashboard#index'

  get 'dashboard' => 'dashboard#index'

  # Token routes
  post 'token/generate' => 'token#generate'

  # Twilio routes
  post 'call/connect' => 'call#connect'
  post 'call/voicemail' => 'call#voicemail'

  # Slack routes
  post 'slack/handle-call' => 'slack#handle_call'
  post 'slack/handle-record' => 'slack#handle_record'

  resources :tickets, only: [:create]
end
