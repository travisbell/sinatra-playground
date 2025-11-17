# frozen_string_literal: true

module Pages
  class Default < Pages::Base
    def description
      "An experiment to see how we can build conventions around our views while still using ERB because ERB is actually pretty good."
    end

    def title
      "ERB Demo"
    end
  end
end
