# frozen_string_literal: true
module Resources
  class UserWithTweets < User
    def initialize(user_with_tweets, tweet = Resources::Tweet)
      @user_with_tweets = user_with_tweets
      @tweet = tweet
      super(user_with_tweets)
    end

    def tweets
      @user_with_tweets[:tweets].map do |tweet|
        @tweet.new(tweet).to_h
      end
    end
  end
end
