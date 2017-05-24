# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Interactors::Tweets::List, type: :interactor do
  let(:search_client) do
    klass = double('Clients::TwitterAPI::SearchTweets')
    allow(klass).to receive(:call).and_return(body: { statuses: 'list of tweets' })
    klass
  end

  subject { described_class.new(search_client: search_client).call }

  it 'returns list of tweets from api client' do
    expect(subject).to eq 'list of tweets'
  end
end
