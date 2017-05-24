# frozen_string_literal: true
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe UsersController, type: :controller do
  describe '#most_mentions' do
    let(:twitter_url) { ENV['TWITTER_BASE_URL'] }
    let(:locaweb_user) { 42 }
    let(:other_user) { 100 }
    let(:another_user) { 101 }
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
      relevant_tweet.merge(user: { followers_count: 100, screen_name: other_user },
                           retweet_count: 100,
                           favorite_count: 100)
    end
    let(:second_relevant_tweet) do
      relevant_tweet.merge(user: { followers_count: 100, screen_name: another_user },
                           retweet_count: 90,
                           favorite_count: 100)
    end
    let(:third_relevant_tweet) do
      relevant_tweet.merge(user: { followers_count: 100, screen_name: other_user },
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
      get :most_mentions
    end

    it 'returns correct status code' do
      expect(response.status).to eq 200
    end

    it 'does not include tweets without locaweb user mention' do
      body = JSON.parse(response.body)
      expect(body['users']).not_to include(hash_including('id' => first_irrelevant_tweet[:id]))
    end

    it 'does not include tweets that replies to locaweb tweet' do
      body = JSON.parse(response.body)
      expect(body['users']).not_to include(hash_including('id' => second_irrelevant_tweet[:id]))
    end

    it 'returns first user as the one with more locaweb mentions' do
      body = JSON.parse(response.body)
      expected = {
        'screen_name' => first_relevant_tweet[:user][:screen_name],
        'followers_count' => first_relevant_tweet[:user][:followers_count],
        'url' => "#{twitter_url}/#{first_relevant_tweet[:user][:screen_name]}",
        'tweets' => [{
          'id' => first_relevant_tweet[:id],
          'retweet_count' => first_relevant_tweet[:retweet_count],
          'favorite_count' => first_relevant_tweet[:favorite_count],
          'text' => first_relevant_tweet[:text],
          'created_at' => first_relevant_tweet[:created_at],
          'url' => "#{twitter_url}/#{first_relevant_tweet[:user][:screen_name]}/status/#{first_relevant_tweet[:id]}"
        }, {
          'id' => third_relevant_tweet[:id],
          'retweet_count' => third_relevant_tweet[:retweet_count],
          'favorite_count' => third_relevant_tweet[:favorite_count],
          'text' => third_relevant_tweet[:text],
          'created_at' => third_relevant_tweet[:created_at],
          'url' => "#{twitter_url}/#{third_relevant_tweet[:user][:screen_name]}/status/#{third_relevant_tweet[:id]}"
        }]
      }
      expect(body['users'][0]).to eq expected
    end

    it 'returns second user as the one with less locaweb mentions' do
      body = JSON.parse(response.body)
      tweet = second_relevant_tweet
      expected = {
        'screen_name' => tweet[:user][:screen_name],
        'followers_count' => tweet[:user][:followers_count],
        'url' => "#{twitter_url}/#{tweet[:user][:screen_name]}",
        'tweets' => [{
          'id' => tweet[:id],
          'retweet_count' => tweet[:retweet_count],
          'favorite_count' => tweet[:favorite_count],
          'text' => tweet[:text],
          'created_at' => tweet[:created_at],
          'url' => "#{twitter_url}/#{tweet[:user][:screen_name]}/status/#{tweet[:id]}"
        }]
      }
      expect(body['users'][1]).to eq expected
    end
  end
end
