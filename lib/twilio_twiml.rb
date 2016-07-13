module TwilioTwiml
  class << self

    def enqueue_response
      Twilio::TwiML::Response.new do |r|
        r.Enqueue 'client_queue', waitUrl: 'http://s3.amazonaws.com/com.twilio.sounds.music/index.xml'
      end
    end

    def dial_twiml(params={})
      Twilio::TwiML::Response.new do |r|
        r.Pause length: 10
        r.Dial dial_params do |dial|
          if params.include?(:phoneNumber) # LPL calls client
            dial.Number params[:phoneNumber]
          else # client calls LPL
            dial.Client 'client_connect', client_params
          end
        end
      end
    end

    def voicemail_twiml(message="")
      Twilio::TwiML::Response.new do |r|
        r.Say message
        r.Record recording_params
      end
    end

    def text_twiml(params={})
      Twilio::TwiML::Response.new do |r|
        r.Sms text_response, sms_params(params[:From])
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
          action: '/call/complete'
        }
      end

      def client_params
        {
          statusCallbackEvent: 'ringing answered',
          statusCallback: "#{Ngrok.web_hook_host}/slack/handle-call"
        }
      end

      def recording_params
        {
          playBeep: true,
          maxLength: ENV['TEST_VOICEMAIL_TIMEOUT'],
          action: '/slack/handle-record',
          trim: 'trim-silence'
        }
      end

      def voicemail_message
        I18n.t(:voicemail_message, scope: :twilio)
      end

      def sms_params(sender)
        {
          to: sender,
          from: twilio_number
        }
      end

      def text_response
        I18n.t(:text_response, scope: :twilio)
      end
  end
end
