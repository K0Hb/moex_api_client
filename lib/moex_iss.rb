# frozen_string_literal: true

require "faraday"
require "json"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module MoexIss
  def self.client
    MoexIss::Client.new
  end
end
