# frozen_string_literal: true
require_relative 'boot'

require 'rails'
require 'action_controller/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LocawebChallenge
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('app')
    config.api_only = true
  end
end
