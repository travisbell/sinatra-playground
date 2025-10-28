#!/usr/bin/env falcon-host
# frozen_string_literal: true

require "falcon/environment/rack"

service "sinatra.localhost" do
  include Falcon::Environment::Rack

  count ENV.fetch("COUNT", 1).to_i
  health_check_timeout 60
  preload "preload.rb"
  rackup_path "config.ru"
  url "http://[::]:#{ENV.fetch("APP_PORT", 8080)}"

  endpoint do
    Async::HTTP::Endpoint.parse(url)
  end
end
