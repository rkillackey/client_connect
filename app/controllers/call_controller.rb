class CallController < ApplicationController
  skip_before_action :verify_authenticity_token

  def connect
    token = generate_token
    create_contact if params.include?('From')
    render xml: ::TwilioTwiml.dial_response(params).to_xml
  end

  def complete_call
    render xml: ::TwilioTwiml.voicemail_response(params).to_xml if params['DialCallStatus'] == 'no-answer'
    render json: { message: "Call completed" }, status: :ok
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
end
