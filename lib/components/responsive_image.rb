# frozen_string_literal: true

module Components
  class ResponsiveImage < BaseComponent
    include Phlex::Rails::Helpers::ClassNames
    include Phlex::Rails::Helpers::ImageTag

    # ERB:
    # <img
    #   alt="<%= h(image_alt)
    #   class="<%= image_type %> w-full"
    #   src="<%= media_cdn_image_by_name(image_path, mobile_image_sizes[0]) %>"
    #   srcset="<%= media_cdn_image_by_name(image_path, mobile_image_sizes[0]) %> 1x, <%= media_cdn_image_by_name(image_path, mobile_image_sizes[1]) %> 2x"
    # %>"

    def view_template
      return unless local?(:image_path)

      image_tag(
        media_cdn_image_by_name(local(:image_path), image_sizes[0]),
        alt: h(local(:image_alt)),
        class: class_names(local(:image_type), "w-full"),
        loading: local(:lazyload, nil) == "false" ? nil : "lazy",
        srcset: {
          media_cdn_image_by_name(local(:image_path), image_sizes[0]) => "1x",
          media_cdn_image_by_name(local(:image_path), image_sizes[1]) => "2x"
        }
      )
    end

    # eg. desktop_image_sizes: ['w220_and_h330_face', 'w440_and_h660_face'],
    #     mobile_image_sizes: ['w220_and_h330_face', 'w440_and_h660_face']
    private def image_sizes
      if mobile_device?
        local(:mobile_image_sizes) || local(:image_sizes, [])
      else
        local(:desktop_image_sizes) || local(:image_sizes, [])
      end
    end
  end
end
