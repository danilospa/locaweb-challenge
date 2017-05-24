# frozen_string_literal: true
require_relative './resourceable'

module Resources
  class Tweet
    include Resourceable

    def initialize(tweet)
      @tweet = tweet
    end

    def id
      @tweet[:id]
    end

    def retweet_count
      @tweet[:retweet_count]
    end

    def favorite_count
      @tweet[:favorite_count]
    end

    def text
      @tweet[:text]
    end

    def created_at
      @tweet[:created_at]
    end

    def url
      "#{ENV['TWITTER_BASE_URL']}/#{@tweet[:user][:screen_name]}/status/#{id}"
    end
  end
end
