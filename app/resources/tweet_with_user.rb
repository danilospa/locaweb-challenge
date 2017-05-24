# frozen_string_literal: true
module Resources
  class TweetWithUser < Tweet
    def initialize(tweet, user = Resources::User)
      @user = user
      super(tweet)
    end

    def user
      @user.new(@tweet[:user]).to_h
    end
  end
end
