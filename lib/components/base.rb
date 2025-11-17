# frozen_string_literal: true

# Making everything html_safe _for now_. Most of the ActionView helpers check and/or
# expect strings to come out of ActiveSupport::SafeBuffer, and if they don't the
# strings are automaticlly escaped. I don't know how to properly deal with this yet.

class Object
  def html_safe?
    true
  end
end

module Components
  class Base
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::DateHelper
    include ActionView::Helpers::FormHelper
    include ActionView::Helpers::FormOptionsHelper
    include ActionView::Helpers::JavaScriptHelper
    include ActionView::Helpers::UrlHelper

    def file_name
      @file_name ||= self.class.name.demodulize.underscore
    end

    def render
      Tilt.new("lib/components/#{file_name}/#{file_name}.erb", bufvar: "@output_buffer", default_encoding: "UTF-8", engine_class: Erubi::CaptureBlockEngine).render(self)
    end
  end
end
