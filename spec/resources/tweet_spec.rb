# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Resources::Tweet, type: :resource do
  it 'includes resourceable' do
    expect(described_class).to include(Resourceable)
  end

  let(:tweet) do
    {
      id: 'tweet id',
      retweet_count: 'retweet count',
      favorite_count: 'favorite count',
      text: 'text',
      created_at: 'create date',
      user: {
        screen_name: 'screen name'
      }
    }
  end

  subject { described_class.new(tweet) }

  describe '#id' do
    it 'returns correct tweet id' do
      expect(subject.id).to eq tweet[:id]
    end
  end

  describe '#retweet_count' do
    it 'returns correct retweet count' do
      expect(subject.retweet_count).to eq tweet[:retweet_count]
    end
  end

  describe '#favorite_count' do
    it 'returns correct favorite count' do
      expect(subject.favorite_count).to eq tweet[:favorite_count]
    end
  end

  describe '#text' do
    it 'returns correct tweet text' do
      expect(subject.text).to eq tweet[:text]
    end
  end

  describe '#created_at' do
    it 'returns correct tweet creation date' do
      expect(subject.created_at).to eq tweet[:created_at]
    end
  end

  describe '#url' do
    it 'returns correct link to tweet' do
      expect(subject.url).to eq "#{ENV['TWITTER_BASE_URL']}/#{tweet[:user][:screen_name]}/status/#{tweet[:id]}"
    end
  end
end
