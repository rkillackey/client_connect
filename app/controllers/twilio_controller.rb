class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def enqueue
    # @contact = create_contact if params.include?('From')
    # ::SlackWebClient.post_message(incoming_call_message)
    # render xml: ::TwilioTwiml.enqueue_response.to_xml
  end

  def connect
    # ::TwilioService.answer_call(params)
    # token = generate_token
    # @contact = create_contact if params.include?('From')
    # ::SlackWebClient.post_message(incoming_call_message)
    # render xml: ::TwilioTwiml.dial_response(params).to_xml
    render xml: ::TwilioService.answer_call(params), status: :ok
  end

  def complete_call
    # render xml: ::TwilioTwiml.voicemail_response.to_xml if params['DialCallStatus'] == 'no-answer'
    render xml: ::TwilioService.complete_call(params), status: :ok
  end

  def post_incoming_call
    response = TwilioService.post_slack_call(params)
    render json: response, status: :ok
  end

  def post_voicemail
    response = TwilioService.post_slack_voicemail(params)
    render json: response, status: :ok
  end

  private

  def generate_token
    ::TwilioCapability.generate(role)
  end

  def role
    'client_connect'
  end

  def create_contact
    Contact.create({
      time_contacted: Time.now,
      data: params
    })
  end

  def incoming_call_message
    "#{I18n.t(:incoming_call_message, scope: :slack, number: ENV['TEST_CALL_TIMEOUT'])} #{Ngrok.web_hook_host}/call?contact=#{@contact.id}"
  end

  def recording_message
    I18n.t(:voicemail_message, scope: :slack)
  end
end
