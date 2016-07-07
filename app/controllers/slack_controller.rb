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
    "You have a new incoming call. Click to following link to answer: "
  end

  def recording_message
    "You have received a new voicemail. Click the following link to view: "
  end
end
