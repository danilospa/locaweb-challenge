# frozen_string_literal: true
Rails.application.routes.draw do
  get :most_relevants, to: 'tweets#most_relevants'
  get :most_mentions, to: 'users#most_mentions'
end
