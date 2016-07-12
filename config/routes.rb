Rails.application.routes.draw do
  root 'dashboard#index'

  # Dashboard
  get 'dashboard'            => 'dashboard#index'
  get 'call'                 => 'dashboard#call'
  post 'notes'               => 'dashboard#notes'

  # Token routes
  post 'token/generate'      => 'token#generate'

  # Twilio routes
  post 'call/connect'        => 'twilio#connect'
  post 'call/complete'       => 'twilio#complete'
  post 'text/connect'        => 'twilio#text'

  # Slack routes
  post 'slack/handle-call'   => 'twilio#post_incoming_call'
  post 'slack/handle-record' => 'twilio#post_voicemail'
end
