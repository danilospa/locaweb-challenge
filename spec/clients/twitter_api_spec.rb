# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Clients::TwitterAPI, type: :client do
  it 'sets correct base url' do
    expect(described_class::BASE_URL).to eq ENV['LOCAWEB_TWEEPS_BASE_URL']
  end

  it 'sets correct headers' do
    expect(described_class::DEFAULT_HEADERS).to eq Username: ENV['TWEEPS_AUTHORIZATION_EMAIL']
  end
end
