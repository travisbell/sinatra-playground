# frozen_string_literal: true

module Pages
  class BasePage < Phlex::HTML
    include Phlex::Rails::Helpers::LinkTo

    def initialize(**options)
    end
  end
end
