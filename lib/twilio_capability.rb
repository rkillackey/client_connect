class TwilioCapability
  class << self
    def generate(role)
      capability = Twilio::Util::Capability.new

      application_sid = ENV['TWIML_APPLICATION_SID']
      capability.allow_client_outgoing application_sid
      capability.allow_client_incoming role

      capability.generate
    end
  end
end
