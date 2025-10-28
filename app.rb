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
    include ActionView::Helpers::FormHelper
    include ActionView::Helpers::FormOptionsHelper
    include ActionView::Helpers::JavaScriptHelper
    include ActionView::Helpers::TagHelper
    include Helpers::PhlexRendering
  end

  register Controllers::Test

  get "/" do
    phlex(Pages::Index.new)
  end
end
