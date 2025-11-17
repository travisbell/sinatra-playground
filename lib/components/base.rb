# frozen_string_literal: true

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
