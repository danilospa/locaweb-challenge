# frozen_string_literal: true
module Clients
  module TwitterAPI
    BASE_URL = ENV['LOCAWEB_TWEEPS_BASE_URL']
    DEFAULT_HEADERS = {
      Username: 'danilospalbuquerque@gmail.com'
    }.freeze
  end
end
