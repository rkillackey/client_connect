module TwilioTwiml
  class << self

    def dial_response
      twiml_response do |r|
        r.Dial dial_params do |dial|
          dial.Client('client_connect')
        end
      end
    end

    def voicemail_response
      twiml_response do |r|
        r.Say voicemail_message
        r.Record recording_params
      end
    end

    def twiml_response
      Twilio::TwiML::Response.new
    end

    private

    def twilio_number
      ENV['TEST_TWILIO_PHONE_NUMBER_VALID']
    end

    def dial_params
      {
        callerId: twilio_number,
        timeout: 20,
        action: '/call/voicemail',
        statusCallBackEvent: 'ringing',
        statusCallback: '/slack/handle-call'
      }
    end

    def recording_params
      {
        playBeep: true,
        maxLength: '30',
        action: '/slack/handle-record'
      }
    end

    def voicemail_message
      "Thank you for calling Launch Pad Lab.
      Please leave a message with information about your project after the tone."
    end
  end
end
