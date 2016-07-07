class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Posts to Slack with message about incoming call and link to answer call (still need to add link)
  def post_incoming_call
    response = ::SlackWebClient.post_message(incoming_call_message)
    # ::SlackWebClient.post_message("#{incoming_call_message} #{call_url}")
    render json: response, status: :ok
  end

  # Posts to Slack with message about voicemail and link to file containing audio recording (still need link)
  def post_voicemail
    response = ::SlackWebClient.post_message(recording_message)
    render json: response, status: :ok
    # ::SlackWebClient.post_message("#{recording_message} #{params['RecordingUrl']}")
  end

  private

  def incoming_call_message
    I18n.t(:incoming_call_message, scope: :slack)
  end

  def recording_message
    I18n.t(:voicemail_message, scope: :slack)
  end
end
