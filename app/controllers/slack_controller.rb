class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def post_incoming_call
    message = call_message["#{params['CallStatus']}"]
    response = ::SlackWebClient.post_message(call_message)
    # ::SlackWebClient.post_message("#{incoming_call_message} #{call_url}")
    render json: response, status: :ok
  end

  def post_voicemail
    response = ::SlackWebClient.post_message(recording_message)
    render json: response, status: :ok
    # ::SlackWebClient.post_message("#{recording_message} #{params['RecordingUrl']}")
  end

  private

  def call_message
    {
      'in-progress' => I18n.t(:call_answered_message, scope: :slack),
      'no-answer' => I18n.t(:incoming_call_message, scope: :slack)
    }
  end

  def recording_message
    I18n.t(:voicemail_message, scope: :slack)
  end
end
