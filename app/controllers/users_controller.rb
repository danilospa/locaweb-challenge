# frozen_string_literal: true
class UsersController < ApplicationController
  def most_mentions
    tweets = Interactors::Tweets::List.new.call
    most_relevant_tweets = Interactors::Tweets::GetMostRelevants.new.call(tweets)
    most_relevant_tweets_ordered = Interactors::Tweets::OrderMostRelevants.new.call(most_relevant_tweets)
    users = Interactors::Tweets::GetUsersOrderedByTweets.new.call(most_relevant_tweets_ordered)

    users_list = users.map do |user|
      Resources::UserWithTweets.new(user).to_h
    end

    render json: { users: users_list }, status: 200
  end
end
