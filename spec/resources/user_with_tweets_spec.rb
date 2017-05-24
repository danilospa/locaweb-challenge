# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Resources::UserWithTweets, type: :resource do
  it 'have correct super class' do
    expect(described_class.superclass).to eq Resources::User
  end

  let(:user_with_tweets) do
    { tweets: tweets }
  end

  let(:tweets) { [first_tweet, second_tweet] }

  let(:first_tweet) { 'first tweet' }
  let(:second_tweet) { 'second tweet' }

  let(:tweet_resource) do
    klass = double('Resources::Tweet')
    allow(klass).to receive(:new).with(first_tweet).and_return(first_tweet_resource_instance)
    allow(klass).to receive(:new).with(second_tweet).and_return(second_tweet_resource_instance)
    klass
  end

  let(:first_tweet_resource_instance) do
    klass = double('Resources::Tweet')
    allow(klass).to receive(:to_h).and_return('first tweet resource')
    klass
  end

  let(:second_tweet_resource_instance) do
    klass = double('Resources::Tweet')
    allow(klass).to receive(:to_h).and_return('second tweet resource')
    klass
  end

  subject { described_class.new(user_with_tweets, tweet_resource) }

  describe '#tweets' do
    it 'returns array of tweets resource' do
      expect(subject.tweets).to eq ['first tweet resource', 'second tweet resource']
    end
  end
end
