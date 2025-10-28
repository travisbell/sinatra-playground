# frozen_string_literal: true

module Components
  class BaseComponent < Phlex::HTML
    def initialize(locals: nil)
      super

      @locals = locals.try(:with_indifferent_access)
    end

    # Move into separate module.
    delegate :h, to: :controller
    def controller = view_context.controller

    def local(key, default = nil)
      locals.fetch(key, default)
    end

    def local?(key)
      locals[key].present?
    end

    def locals
      @locals ||= view_context.assigns
    end
  end
end
