# frozen_string_literal: true
module Interactors
  module Tweets
    class List
      def initialize(options = {})
        @search_client = options.fetch(:search_client, Clients::TwitterAPI::SearchTweets.new)
      end

      def call
        @search_client.call[:body][:statuses]
      end
    end
  end
end
