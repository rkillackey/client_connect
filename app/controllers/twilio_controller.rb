class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action -> { create_contact(params) }, only: [:connect, :text]

  def connect
    render xml: ::TwilioService.answer_call(params.merge({ contact: @contact })), status: :ok
  end

  def answer
    response = ::TwilioService.post_slack_call(params)
    render json: response, status: :ok
  end

  def complete
    render xml: ::TwilioService.send_to_voicemail(params), status: :ok
  end

  def voicemail
    render xml: ::TwilioService.handle_voicemail_recording(params), status: :ok
  end

  def text
    render xml: ::TwilioService.text_response(params), status: :ok
  end

  private

    def create_contact(params)
      @contact ||= Contact.create({
        time_contacted: Time.now,
        data: params
      }) unless params['From'].include?('client')
    end
end
