# frozen_string_literal: true

require "tilt/erubi"
require "erubi/capture_block"

module Pages
  class Base
    def initialize(**attrs)
      @app = attrs[:app]
      @config = attrs[:config]
      @layout = Tilt.new("views/#{attrs[:layout]}.erb", bufvar: "@output_buffer", default_encoding: "UTF-8")
      @locals = attrs[:locals]
      @template = Tilt.new("views/#{attrs[:template]}.erb", bufvar: "@output_buffer", default_encoding: "UTF-8")

      load_config

      # Tilt.finalize!
    end

    def load_config
      set_locale
    end

    def params
      @app.params
    end

    def render
      @layout.render(Object.new, @locals) { @template.render(self, @locals) }
    end

    def request_cache
      ActiveSupport::IsolatedExecutionState[:request_cache] ||= {}
    end

    def set_locale
      I18n.locale = params[:locale] || @config[:locale] || I18n.default_locale
    end
  end
end
