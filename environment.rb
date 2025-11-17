# frozen_string_literal: true

RACK_ENV = ActiveSupport::EnvironmentInquirer.new(ENV["RACK_ENV"].presence || "development")

class Environment
  class << self
    def loader
      @_loader ||= Zeitwerk::Loader.new
    end

    def init
      Environment.loader.push_dir(__dir__)
      Environment.loader.push_dir("#{__dir__}/lib")
      Environment.loader.collapse("#{__dir__}/lib/components/*")
      Environment.loader.enable_reloading
      Environment.loader.setup
      # Environment.loader.eager_load
    end
  end
end

Environment.init
