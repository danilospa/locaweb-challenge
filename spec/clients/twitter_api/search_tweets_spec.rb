# frozen_string_literal: true
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Clients::TwitterAPI::SearchTweets, type: :client do
  let(:path) { "#{Clients::TwitterAPI::BASE_URL}/tweeps" }

  context 'when endpoint returns a string' do
    before do
      stub_request(:get, path)
        .with(headers: Clients::TwitterAPI::DEFAULT_HEADERS)
        .and_return(body: 'string', status: 200)
    end

    subject { described_class.new.call }

    it 'returns correct status' do
      expect(subject[:status]).to eq 200
    end

    it 'returns body as string' do
      expect(subject[:body]).to eq 'string'
    end
  end

  context 'when endpoint returns a json' do
    before do
      stub_request(:get, path)
        .with(headers: Clients::TwitterAPI::DEFAULT_HEADERS)
        .and_return(body: { field: 'value' }.to_json, status: 200)
    end

    subject { described_class.new.call }

    it 'returns correct status' do
      expect(subject[:status]).to eq 200
    end

    it 'returns body hash' do
      expect(subject[:body]).to eq field: 'value'
    end
  end
end
