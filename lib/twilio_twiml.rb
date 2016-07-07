module TwilioTwiml
  class << self

    def dial_response(params={})
      Twilio::TwiML::Response.new do |r|
        r.Pause 30
        r.Dial dial_params do |dial|
          if params.include?(:phoneNumber)
            dial.Number params[:phoneNumber]
          else
            dial.Client 'client_connect', client_params
          end
        end
      end
    end

    def voicemail_response(params={})
      Twilio::TwiML::Response.new do |r|
        r.Say voicemail_message
        # r.Record recording_params
      end
    end

    private

    def twilio_number
      ENV['TWILIO_PHONE_NUMBER']
    end

    def dial_params
      {
        callerId: twilio_number,
        timeout: ENV['TEST_CALL_TIMEOUT'],
        action: '/call/complete-call'
      }
    end

    def client_params
      {
        statusCallbackEvent: 'ringing',
        statusCallback: 'http://fc9f56eb.ngrok.io/slack/handle-call'
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
      "Thank you for calling Launch Pad Lab. Please leave a message with information about your project after the tone."
    end
  end
end
