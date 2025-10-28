# frozen_string_literal: true

require "bundler"
Bundler.require

require_relative "environment"

use(Middleware::RequestLogger)

run ->(env) { App.call(env) }
