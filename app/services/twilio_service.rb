module TwilioService
  class << self

    def answer_call(params={})
      @contact ||= params[:contact]
      ::SlackWebClient.post_message(slack_call_message('ringing')) unless params['From'].include?('client')
      ::TwilioTwiml.dial_twiml(params).to_xml
    end

    def finish_call(params={})
      if params['DialCallStatus'] == 'no-answer' && !params['Caller'].include?('client')
        ::TwilioTwiml.voicemail_twiml(voicemail_message).to_xml
      else
        ::TwilioTwiml.hangup_twiml.to_xml
      end
    end

    def post_slack_call(params={})
      status ||= params['CallStatus']
      ::SlackWebClient.post_message(slack_call_message(status))
    end

    def handle_voicemail_recording(params={})
      url ||= params['RecordingUrl']
      add_voicemail_link(url)
      ::SlackWebClient.post_message(slack_recording_message(url))
      ::TwilioTwiml.hangup_twiml.to_xml
    end

    def text_response(params={})
      args = { sender: params[:From], body: params[:Body] }
      ::SlackWebClient.post_message(slack_text_message(args))
      ::TwilioTwiml.text_twiml(params).to_xml
    end

    private

      def slack_call_message(status)
        link = "#{ENV['HEROKU_URL']}/contacts/#{@contact.id}"
        message = {
          'in-progress' => I18n.t(:call_answered_message, scope: :slack),
          'ringing' => "#{I18n.t(:incoming_call_message, scope: :slack, link: link)}"
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

      def add_voicemail_link(url)
        @contact.update_attributes({ voicemail_link: url }) if @contact
      end
  end
end
