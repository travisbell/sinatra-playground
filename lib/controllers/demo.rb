# frozen_string_literal: true

require "sinatra/extension"

module Controllers
  module Demo
    extend Sinatra::Extension

    get "/demo/?" do
      Pages::Default.new(
        app: self,
        config: {
          locale: "en"
        },
        layout: :layout,
        locals: {
          title: "ERB Demo"
        },
        template: :index
      ).render
    end
  end
end
