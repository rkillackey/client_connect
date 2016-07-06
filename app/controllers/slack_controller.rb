class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Posts to Slack with message about incoming call and link to answer call
  def handle_call
    ::SlackWebClient.post_message(incoming_call_message)
  end

  # Posts to Slack with message about voicemail and link to file containing audio recording
  def handle_record
    ::SlackWebClient.post_message(recording_message)
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
