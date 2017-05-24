# frozen_string_literal: true
require_relative './resourceable'

module Resources
  class User
    include Resourceable

    def initialize(user)
      @user = user
    end

    def screen_name
      @user[:screen_name]
    end

    def followers_count
      @user[:followers_count]
    end

    def url
      "#{ENV['TWITTER_BASE_URL']}/#{screen_name}"
    end
  end
end
