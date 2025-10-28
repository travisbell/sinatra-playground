# frozen_string_literal: true

require "rack/constants"
require "rack/utils"
require "rack/body_proxy"
require "rack/request"

module Middleware
  class RequestLogger
    def initialize(app, logger = nil)
      @app = app
      @logger = logger
    end

    def call(env)
      began_at = Rack::Utils.clock_time
      status, headers, body = response = @app.call(env)

      response[2] = Rack::BodyProxy.new(body) { log(env, status, headers, began_at) }
      response
    end

    private

    def log(env, status, response_headers, began_at)
      request = Rack::Request.new(env)

      msg = {
        status: status,
        source_address: request.ip || "-",
        content_type: extract_content_type(response_headers),
        content_length: extract_content_length(response_headers),
        duration: (Rack::Utils.clock_time - began_at).round(4)
      }

      if status.between?(200, 399)
        Console.info(path(request), msg)
      elsif status.between?(400, 499)
        Console.warn(path(request), msg)
      else
        Console.error(path(request), msg)
      end
    end

    def extract_content_length(headers)
      headers.fetch(Rack::CONTENT_LENGTH, 0).to_i
    end

    def extract_content_type(headers)
      headers.fetch(Rack::CONTENT_TYPE, nil)
    end

    def path(request)
      "#{request.request_method} #{request.path_info}#{"?#{request.query_string}" unless request.query_string.empty?}"
    end
  end
end
