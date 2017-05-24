# frozen_string_literal: true
module Interactors
  module Tweets
    class OrderMostRelevants
      def call(tweets)
        tweets.sort_by do |tweet|
          tweet[:user][:followers_count] * 100 + tweet[:retweet_count] * 10 + tweet[:favorite_count]
        end.reverse
      end
    end
  end
end
