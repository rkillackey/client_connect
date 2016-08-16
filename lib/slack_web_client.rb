module SlackWebClient
  class << self

    def client
      @client ||= Slack::Web::Client.new
    end

    def channel
      "##{ENV['SLACK_CHANNEL']}"
    end

    def message_params
      {
        channel: channel,
        as_user: true
      }
    end

    def post_message(message)
      client.chat_postMessage(message_params.merge({ text: "<@channel> #{message}" }))
    end
  end
end
