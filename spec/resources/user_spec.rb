# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Resources::User, type: :resource do
  it 'includes resourceable' do
    expect(described_class).to include(Resourceable)
  end

  let(:user) do
    { screen_name: 'screen name',
      followers_count: 'followers count' }
  end

  subject { described_class.new(user) }

  describe '#screen_name' do
    it 'returns correct screen name' do
      expect(subject.screen_name).to eq user[:screen_name]
    end
  end

  describe '#followers_count' do
    it 'returns correct followers count' do
      expect(subject.followers_count).to eq user[:followers_count]
    end
  end

  describe '#url' do
    it 'returns correct link to user page' do
      expect(subject.url).to eq "#{ENV['TWITTER_BASE_URL']}/#{user[:screen_name]}"
    end
  end
end
