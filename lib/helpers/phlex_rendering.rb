# frozen_string_literal: true

require "action_dispatch"
require "action_view"
require "phlex/rails"

module Helpers
  module PhlexRendering
    # This method is the main entry point for rendering a Phlex component using ActionView as
    # a render to get access to the full suite of tag helpers provided by Rails.
    #
    # See also: https://github.com/benpickles/phlex-sinatra
    def phlex(component, **options)
      component = component.is_a?(::Phlex::SGML) ? component : component.new

      assigns = options[:assigns] || options[:locals] || {}
      view_context = view_context_class.new(lookup_context, assigns, self)
      view_context.render(renderable: component)
    end

    def view_context_class
      @view_context_class ||= ActionView::Base.with_empty_template_cache
    end

    def lookup_context
      @lookup_context ||= ActionView::LookupContext.new(ActionView::PathSet.new(["lib/components", "lib/views"]))
    end
  end
end

module RequestOverrides
  def headers
    @headers ||= ActionDispatch::Http::Headers.new(self)
  end
end

if Object.const_defined?(:Sinatra) && Sinatra.const_defined?(:Request)
  Sinatra::Request.include(RequestOverrides)
end
