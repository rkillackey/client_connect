module Ngrok
  class << self
    def web_hook_host
      Rails.env.development? ?
        JSON.parse(HTTParty.get(ngrok_host).body)['tunnels'][0]['public_url'] :
        request.base_url
    end

    def ngrok_host
      'http://localhost:4040/api/tunnels'
    end
  end
end
