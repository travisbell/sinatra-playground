# frozen_string_literal: true

module Pages
  class Index < BasePage
    def view_template
      html do
        doctype

        head do
          title { "Phlex Demo" }
          link(href: "screen.css", rel: "stylesheet")
        end

        body do
          h2 { "Hello, Phlex!" }

          div(class: "") do
            yield if block_given?

            p { "This is the index." }

            p do
              plain("Here's a demo link: ")
              link_to("/test/demo", "/test/demo")
            end
          end
        end
      end
    end
  end
end
