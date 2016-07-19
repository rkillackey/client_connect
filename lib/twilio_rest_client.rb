module TwilioRestClient
  class << self

    def client
      @client ||= Twilio::Rest::Client.new
    end

    def account
      @account ||= client.accounts.get(ENV['TWILIO_SID'])
    end

    def get(sid)
      account.calls.get(sid)
    end

    def create_outgoing_call(params={})
      account.calls.create(params)
    end
  end
end
