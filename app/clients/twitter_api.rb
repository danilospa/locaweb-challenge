# frozen_string_literal: true
module Clients
  module TwitterAPI
    BASE_URL = ENV['LOCAWEB_TWEEPS_BASE_URL']
    DEFAULT_HEADERS = {
      Username: ENV['TWEEPS_AUTHORIZATION_EMAIL']
    }.freeze
  end
end
