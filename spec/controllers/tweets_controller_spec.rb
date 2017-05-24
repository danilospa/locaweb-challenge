# frozen_string_literal: true
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe TweetsController, type: :controller do
  describe '#most_relevants' do
    let(:twitter_url) { ENV['TWITTER_BASE_URL'] }
    let(:locaweb_user) { 42 }
    let(:other_user) { 100 }
    let(:first_irrelevant_tweet) do
      {
        id: 'first irrelevant tweet id',
        entities: {
          user_mentions: [{ id: other_user }]
        }
      }
    end
    let(:second_irrelevant_tweet) do
      {
        id: 'second irrelevant tweet id',
        in_reply_to_user: locaweb_user,
        entities: {
          user_mentions: []
        }
      }
    end
    let(:relevant_tweet) do
      {
        entities: {
          user_mentions: [{ id: locaweb_user }, { id: other_user }]
        }
      }
    end
    let(:first_relevant_tweet) do
      relevant_tweet.merge(user: { followers_count: 100 },
                           retweet_count: 100,
                           favorite_count: 100)
    end
    let(:second_relevant_tweet) do
      relevant_tweet.merge(user: { followers_count: 100 },
                           retweet_count: 90,
                           favorite_count: 100)
    end
    let(:third_relevant_tweet) do
      relevant_tweet.merge(user: { followers_count: 100 },
                           retweet_count: 90,
                           favorite_count: 90)
    end
    let(:tweets_response) do
      { statuses: [first_irrelevant_tweet, third_relevant_tweet, first_relevant_tweet,
                   second_irrelevant_tweet, second_relevant_tweet] }
    end

    before do
      stub_request(:get, 'http://tweeps.locaweb.com.br/tweeps')
        .with(headers: { Username: 'danilospalbuquerque@gmail.com' })
        .and_return(body: tweets_response.to_json)
      get :most_relevants
    end

    it 'returns correct status code' do
      expect(response.status).to eq 200
    end

    it 'does not include tweets without locaweb user mention' do
      body = JSON.parse(response.body)
      expect(body['tweets']).not_to include(hash_including('id' => first_irrelevant_tweet[:id]))
    end

    it 'does not include tweets that replies to locaweb tweet' do
      body = JSON.parse(response.body)
      expect(body['tweets']).not_to include(hash_including('id' => second_irrelevant_tweet[:id]))
    end

    it 'returns first tweet as the one with more user followers' do
      body = JSON.parse(response.body)
      tweet = first_relevant_tweet
      expected = {
        'id' => tweet[:id],
        'retweet_count' => tweet[:retweet_count],
        'favorite_count' => tweet[:favorite_count],
        'text' => tweet[:text],
        'created_at' => tweet[:created_at],
        'url' => "#{twitter_url}/#{tweet[:user][:screen_name]}/status/#{tweet[:id]}",
        'user' => {
          'screen_name' => tweet[:user][:screen_name],
          'followers_count' => tweet[:user][:followers_count],
          'url' => "#{twitter_url}/#{tweet[:user][:screen_name]}"
        }
      }
      expect(body['tweets'][0]).to eq expected
    end

    it 'returns second tweet as the one with more retweets' do
      body = JSON.parse(response.body)
      tweet = second_relevant_tweet
      expected = {
        'id' => tweet[:id],
        'retweet_count' => tweet[:retweet_count],
        'favorite_count' => tweet[:favorite_count],
        'text' => tweet[:text],
        'created_at' => tweet[:created_at],
        'url' => "#{twitter_url}/#{tweet[:user][:screen_name]}/status/#{tweet[:id]}",
        'user' => {
          'screen_name' => tweet[:user][:screen_name],
          'followers_count' => tweet[:user][:followers_count],
          'url' => "#{twitter_url}/#{tweet[:user][:screen_name]}"
        }
      }
      expect(body['tweets'][1]).to eq expected
    end

    it 'returns third tweet as the one with more favorites count' do
      body = JSON.parse(response.body)
      tweet = third_relevant_tweet
      expected = {
        'id' => tweet[:id],
        'retweet_count' => tweet[:retweet_count],
        'favorite_count' => tweet[:favorite_count],
        'text' => tweet[:text],
        'created_at' => tweet[:created_at],
        'url' => "#{twitter_url}/#{tweet[:user][:screen_name]}/status/#{tweet[:id]}",
        'user' => {
          'screen_name' => tweet[:user][:screen_name],
          'followers_count' => tweet[:user][:followers_count],
          'url' => "#{twitter_url}/#{tweet[:user][:screen_name]}"
        }
      }
      expect(body['tweets'][2]).to eq expected
    end
  end
end
