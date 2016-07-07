class TokenController < ApplicationController
  skip_before_action :verify_authenticity_token

  def generate
    token = ::TwilioCapability.generate(role)
    render json: { token: token }
  end

  def role
    params[:page] == root_path ? 'client_connect' : 'client'
  end
end
