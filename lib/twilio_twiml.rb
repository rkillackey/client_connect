module TwilioTwiml
  class << self

    def dial_twiml(params={})
      if params.include?(:phoneNumber)
        Twilio::TwiML::Response.new do |r|
          r.Dial dial_params do |dial|
            dial.Number params[:phoneNumber]
          end
        end
      else
        Twilio::TwiML::Response.new do |r|
          r.Pause length: ENV['DIAL_PAUSE_LENGTH']
          r.Dial dial_params do |dial|
            dial.Client 'client_connect', client_params
          end
        end
      end
    end

    def voicemail_twiml(message="")
      Twilio::TwiML::Response.new do |r|
        r.Play '/LPL1.mp3'
        r.Record recording_params
      end
    end

    def text_twiml(params={})
      Twilio::TwiML::Response.new do |r|
        r.Sms text_response, sms_params(params[:From])
      end
    end

    def hangup_twiml
      Twilio::TwiML::Response.new do |r|
        r.Hangup
      end
    end

    private

      def twilio_number
        ENV['TWILIO_PHONE_NUMBER']
      end

      def dial_params
        {
          callerId: twilio_number,
          timeout: ENV['CALL_TIMEOUT'],
          action: '/call/complete'
        }
      end

      def client_params
        {
          statusCallbackEvent: 'answered',
          statusCallback: "#{ENV['HEROKU_URL']}/slack/handle-call"
        }
      end

      def recording_params
        {
          playBeep: true,
          maxLength: ENV['VOICEMAIL_TIMEOUT'],
          action: '/slack/handle-record',
          trim: 'trim-silence'
        }
      end

      def sms_params(sender)
        {
          to: sender,
          from: twilio_number
        }
      end

      def voicemail_message
        I18n.t(:voicemail_message, scope: :twilio)
      end

      def text_response
        I18n.t(:text_response, scope: :twilio)
      end
  end
end
