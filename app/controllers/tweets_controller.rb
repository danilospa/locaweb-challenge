# frozen_string_literal: true
class TweetsController < ApplicationController
  def most_relevants
    tweets = Interactors::Tweets::List.new.call
    most_relevant_tweets = Interactors::Tweets::GetMostRelevants.new.call(tweets)
    most_relevant_tweets_ordered = Interactors::Tweets::OrderMostRelevants.new.call(most_relevant_tweets)

    tweets_list = most_relevant_tweets_ordered.map do |tweet|
      Resources::TweetWithUser.new(tweet).to_h
    end

    render json: { tweets: tweets_list }, status: 200
  end
end
