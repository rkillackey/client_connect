class TwilioService
  class << self

    def answer_call(params={}, contact)
      @contact = contact
      ::SlackWebClient.post_message(slack_call_message('ringing')) unless params[:From].include?('client')
      ::TwilioTwiml.dial_twiml(params).to_xml
    end

    def send_to_voicemail(params={})
      ::TwilioTwiml.voicemail_twiml(voicemail_message).to_xml if params['DialCallStatus'] == 'no-answer'
    end

    def post_slack_call(params={})
      status ||= params['CallStatus']
      ::SlackWebClient.post_message(slack_call_message(status)) unless params['Direction'] == 'outbound-dial'
    end

    def post_slack_voicemail(params={})
      url ||= params['RecordingUrl']
      ::SlackWebClient.post_message(slack_recording_message(url))
    end

    def text_response(params={})
      args = { sender: params[:From], body: params[:Body] }
      ::SlackWebClient.post_message(slack_text_message(args))
      ::TwilioTwiml.text_twiml(params).to_xml
    end

    private

      def slack_call_message(status)
        message = {
          'in-progress' => I18n.t(:call_answered_message, scope: :slack),
          'ringing' => "#{I18n.t(:incoming_call_message, scope: :slack, link: Ngrok.web_hook_host/contacts/@contact.id)}"
        }.with_indifferent_access

        message[status]
      end

      def slack_recording_message(url)
        I18n.t(:voicemail_message, scope: :slack, link: url)
      end

      def voicemail_message
        I18n.t(:voicemail_message, scope: :twilio)
      end

      def slack_text_message(args)
        I18n.t(:text_message, scope: :slack, sender: args[:sender], body: args[:body])
      end
  end
end
