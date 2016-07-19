Rails.application.routes.draw do
  root 'dashboard#index'

  # Token routes
  post 'token/generate'      => 'token#generate'

  # Twilio routes
  post 'call/connect'        => 'twilio#connect'
  post 'call/complete'       => 'twilio#complete'
  post 'text/connect'        => 'twilio#text'
  post 'slack/handle-call'   => 'twilio#answer'
  post 'slack/handle-record' => 'twilio#voicemail'

  resources :contacts, only: [:update, :show]
end
