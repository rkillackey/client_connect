class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def enqueue
    @contact = create_contact if params.include?('From')
    # ::SlackWebClient.post_message(incoming_call_message)
    render xml: ::TwilioTwiml.enqueue_response.to_xml
  end

  def connect
    render xml: ::TwilioService.answer_call(params), status: :ok
  end

  def complete_call
    render xml: ::TwilioService.complete_call(params), status: :ok
  end

  def post_incoming_call
    response = ::TwilioService.post_slack_call(params)
    render json: response, status: :ok
  end

  def post_voicemail
    response = ::TwilioService.post_slack_voicemail(params)
    render json: response, status: :ok
  end

  def text
    render xml: ::TwilioService.text_response(params), status: :ok
  end
end
