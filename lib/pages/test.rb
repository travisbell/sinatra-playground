# frozen_string_literal: true

module Pages
  class Test < BasePage
    def initialize(**options)
      super

      @id = options[:id]
    end

    def view_template
      html do
        doctype

        head do
          title { "Phlex Demo" }
          link(href: "screen.css", rel: "stylesheet")
        end

        body do
          h2 { "Hello, Phlex!" }

          div(class: "text-red") do
            yield if block_given?

            p { "This is the index of the test controller." }
            p { "You've requested ID: #{@id}" }

            link_to("back to index", "/")
          end
        end
      end
    end
  end
end
