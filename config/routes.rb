# frozen_string_literal: true
Rails.application.routes.draw do
  get :most_relevants, to: 'tweets#most_relevants'
end
