require "application_responder"

class API::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  self.responder = ApplicationResponder

  before_filter :restrict_access

  private

  def default_serializer_options
    {
        root: false
    }
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      token == ENV['HOWITZER_TOKEN']
    end
  end

end