# frozen_string_literal: true
module Interactors
  module Tweets
    class GetUsersOrderedByTweets
      def call(tweets)
        users = tweets.map { |t| t[:user] }.uniq
        users_with_tweets = users.map do |user|
          user_tweets = tweets.select { |t| t[:user][:screen_name] == user[:screen_name] }
          user.merge(tweets: user_tweets)
        end
        users_with_tweets.sort_by { |u| !u[:tweets].size }
      end
    end
  end
end
