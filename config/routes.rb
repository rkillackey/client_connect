Rails.application.routes.draw do
  root 'dashboard#index'

  # Token routes
  post 'token/generate'      => 'token#generate'

  # Twilio routes
  post 'call/connect'        => 'twilio#connect'
  post 'call/complete'       => 'twilio#complete'
  post 'text/connect'        => 'twilio#text'
  post 'slack/handle-call'   => 'twilio#post_incoming_call'
  post 'slack/handle-record' => 'twilio#post_voicemail'

  resources :contacts, only: [:update, :show]
end
