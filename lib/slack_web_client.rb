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
        as_user: true,
        link_names: 1
      }
    end

    def post_message(message)
      client.chat_postMessage(message_params.merge({ text: message }))
    end
  end
end
