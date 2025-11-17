# frozen_string_literal: true

class App < Sinatra::Base
  set :environment, :development

  configure do
    disable :protection
  end

  configure :development do
    require "listen"
    Listen.to(".", latency: 0.25, only: /\.rb$/) do |_modified, _added, _removed|
      Environment.loader.reload
    rescue Zeitwerk::SetupRequired
    end&.start

    # require "async/safe"
    # Async::Safe.enable!
  end

  helpers do
  end

  register Controllers::Demo
end
