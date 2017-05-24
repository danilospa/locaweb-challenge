# frozen_string_literal: true
require 'net/http'

module Clients
  module TwitterAPI
    class SearchTweets
      def call
        uri = URI("#{BASE_URL}/tweeps")
        headers = DEFAULT_HEADERS
        request = Net::HTTP::Get.new(uri)

        headers.each do |header, value|
          request[header.to_s] = value
        end

        response = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(request) }

        body = begin
                 JSON.parse(response.body).deep_symbolize_keys
               rescue JSON::ParserError
                 response.body
               end

        {
          status: response.code.to_i,
          body: body
        }
      end
    end
  end
end
