# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Interactors::Tweets::GetUsersOrderedByTweets, type: :interactor do
  let(:first_user) do
    { screen_name: 'first user' }
  end
  let(:second_user) do
    { screen_name: 'second user' }
  end

  let(:first_tweet) do
    { user: first_user }
  end

  let(:second_tweet) do
    { user: second_user }
  end

  let(:third_tweet) do
    { user: first_user }
  end

  let(:tweets) do
    [first_tweet, second_tweet, third_tweet]
  end

  subject { described_class.new.call(tweets) }

  it 'returns users ordered by tweets count' do
    first_user_with_tweets = first_user.merge(tweets: [first_tweet, third_tweet])
    second_user_with_tweets = second_user.merge(tweets: [second_tweet])
    expect(subject).to eq [first_user_with_tweets, second_user_with_tweets]
  end
end
