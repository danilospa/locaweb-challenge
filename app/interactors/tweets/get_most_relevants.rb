# frozen_string_literal: true
module Interactors
  module Tweets
    class GetMostRelevants
      LOCAWEB_USER_ID = 42

      def call(tweets)
        tweets.select do |tweet|
          locaweb_mention = tweet[:entities][:user_mentions].any? { |u| u[:id] == LOCAWEB_USER_ID }
          reply_to_locaweb = tweet[:in_reply_to_user_id] == LOCAWEB_USER_ID
          locaweb_mention && !reply_to_locaweb
        end
      end
    end
  end
end
