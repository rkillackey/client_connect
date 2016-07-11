class TwilioService
  class << self
    # before_action -> { create_contact(params) }, only: [:answer_call, :text_response]

    def answer_call(params={})
      @contact ||= create_contact(params)
      ::SlackWebClient.post_message(slack_call_message('ringing'))
      ::TwilioTwiml.dial_response(params).to_xml
    end

    def complete_call(params={})
      ::TwilioTwiml.voicemail_response(voicemail_message).to_xml if params['DialCallStatus'] == 'no-answer'
    end

    def post_slack_call(params={})
      status ||= params['CallStatus']
      ::SlackWebClient.post_message(slack_call_message(status))
    end

    def post_slack_voicemail(params={})
      url ||= params['RecordingUrl']
      ::SlackWebClient.post_message(slack_recording_message(url))
    end

    def text_response(params={})
      args = { sender: params[:From], body: params[:Body] }
      ::SlackWebClient.post_message(slack_text_message(args))
      ::TwilioTwiml.send_text_message(params).to_xml
    end

    private

    def create_contact(params)
      Contact.create({
        time_contacted: Time.now,
        data: params
      })
    end

    def slack_call_message(status)
      message = {
        'in-progress' => I18n.t(:call_answered_message, scope: :slack),
        'ringing' => "#{I18n.t(:incoming_call_message, scope: :slack, link: Ngrok.web_hook_host)}"
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
