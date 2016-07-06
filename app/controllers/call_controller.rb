class CallController < ApplicationController
  skip_before_action :verify_authenticity_token

  def connect
    render xml: twilio_reponse.to_xml
    # render xml: ::TwilioTwiml.dial_response.to_xml
  end

  def voicemail
    render xml: voicemail_response.to_xml if params['DialCallStatus'] == 'no-answer'
  end

  private

  def twilio_reponse
    twilio_number = ENV['TEST_TWILIO_PHONE_NUMBER_VALID']

    Twilio::TwiML::Response.new do |response|
      response.Dial callerId: twilio_number, timeout: 20, action: '/call/voicemail' do |dial|
        if params.include?(:phoneNumber)
          dial.Number params[:phoneNumber] 
        else
          dial.Client('client_connect'), statusCallBackEvent: 'ringing', statusCallback: '/slack/handle-call'
        end
      end
    end
  end

  def voicemail_response
    Twilio::TwiML::Response.new do |r|
      # r.Say voicemail_message
      r.Redirect '/slack/handle-record'
      # r.Record playBeep: true, maxLength: '30', action: '/slack/handle-record'
      # send params['RecordingUrl'] to Slack
    end
  end

  def voicemail_message
    "Thank you for calling Launch Pad Lab.
    Please leave a message with information about your project after the tone."
  end
end
