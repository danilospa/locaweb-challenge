# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Resources::TweetWithUser, type: :resource do
  it 'have correct super class' do
    expect(described_class.superclass).to eq Resources::Tweet
  end

  let(:tweet) do
    { user: 'user info' }
  end

  let(:user_resource) do
    klass = double('Resources::User')
    allow(klass).to receive(:new).with(tweet[:user]).and_return(klass)
    allow(klass).to receive(:to_h).and_return('user resource')
    klass
  end

  subject { described_class.new(tweet, user_resource) }

  describe '#user' do
    it 'returns User resource' do
      expect(subject.user).to eq 'user resource'
    end
  end
end
