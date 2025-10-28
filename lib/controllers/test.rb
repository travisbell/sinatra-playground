# frozen_string_literal: true

require "sinatra/extension"

module Controllers
  module Test
    extend Sinatra::Extension

    get "/test", provides: "json" do
      {
        controller: request.path,
        time: Time.now.iso8601
      }.to_json
    end

    get "/test/:id/?" do
      phlex(Pages::Test.new(id: params[:id]))
    end
  end
end
