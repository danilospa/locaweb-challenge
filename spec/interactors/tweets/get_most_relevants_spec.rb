# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Interactors::Tweets::GetMostRelevants, type: :interactor do
  let(:locaweb_user_id) { described_class::LOCAWEB_USER_ID }
  let(:other_user_id) { 100 }

  let(:relevant_tweet) do
    {
      entities: {
        user_mentions: [{ id: locaweb_user_id }, { id: other_user_id }]
      },
      in_reply_to_user_id: other_user_id
    }
  end
  let(:first_irrelevant_tweet) do
    {
      entities: {
        user_mentions: [{ id: locaweb_user_id }, { id: other_user_id }]
      },
      in_reply_to_user_id: locaweb_user_id
    }
  end
  let(:second_irrelevant_tweet) do
    {
      entities: {
        user_mentions: [{ id: other_user_id }]
      },
      in_reply_to_user_id: other_user_id
    }
  end

  let(:tweets) do
    [relevant_tweet, first_irrelevant_tweet, second_irrelevant_tweet]
  end

  subject { described_class.new.call(tweets) }

  it 'includes only tweets that have locaweb user mention and does not replies to locaweb tweet' do
    expect(subject).to eq [relevant_tweet]
  end
end
