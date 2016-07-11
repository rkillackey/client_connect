class TwilioService
  class << self

    def answer_call(params={})
      @contact ||= create_contact(params)
      ::SlackWebClient.post_message(slack_call_message('ringing'))
      ::TwilioTwiml.dial_response(params).to_xml
    end

    def complete_call(params={})
      ::TwilioTwiml.voicemail_response(voicemail_message).to_xml if params['DialCallStatus'] == 'no-answer'
    end

    def post_slack_call(params={})
      status = params['CallStatus']
      response = ::SlackWebClient.post_message(slack_call_message(status))
    end

    def post_slack_voicemail(params={})
      # url = params['RecordingUrl']
      response = ::SlackWebClient.post_message(slack_recording_message(url))
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
        'ringing' => "#{I18n.t(:incoming_call_message, scope: :slack)} #{Ngrok.web_hook_host}/call?contact=#{@contact.id}"
      }.with_indifferent_access
      message[status]
    end

    def slack_recording_message(url)
      I18n.t(:voicemail_message, scope: :slack, url: url)
    end

    def voicemail_message
      I18n.t(:voicemail_message, scope: :twilio)
    end
  end
end
