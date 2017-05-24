# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Interactors::Tweets::OrderMostRelevants, type: :interactor do
  let(:first_relevant_tweet) do
    {
      user: { followers_count: 100 },
      retweet_count: 100,
      favorite_count: 100
    }
  end
  let(:second_relevant_tweet) do
    first_relevant_tweet.merge(retweet_count: 99)
  end
  let(:third_relevant_tweet) do
    second_relevant_tweet.merge(favorite_count: 99)
  end

  let(:tweets) do
    [third_relevant_tweet, first_relevant_tweet, second_relevant_tweet]
  end

  subject { described_class.new.call(tweets) }

  it 'orders tweets by user followers, then by retweet count, then by favorite count' do
    expect(subject).to eq [first_relevant_tweet, second_relevant_tweet, third_relevant_tweet]
  end
end
