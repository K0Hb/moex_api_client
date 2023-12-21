# frozen_string_literal: true

require_relative "lib/moex_api_client/version"

Gem::Specification.new do |s|
  s.name = "moex_api_client"
  s.version = MoexApiClient::VERSION
  s.authors = ["Vyacheslav Konovalov"]
  s.email = ["goplit2010.konovalov@yandex.ru"]
  s.homepage = "https://github.com/K0Hb/moex_api_client"
  s.summary = "Client for MOEX API"
  s.description = "Client for MOEX API"

  s.metadata = {
    "bug_tracker_uri" => "https://github.com/K0Hb/moex_api_client/issues",
    "changelog_uri" => "https://github.com/K0Hb/moex_api_client/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/K0Hb/moex_api_client",
    "homepage_uri" => "https://github.com/K0Hb/moex_api_client",
    "source_code_uri" => "https://github.com/K0Hb/moex_api_client"
  }

  s.license = "MIT"

  s.files = Dir.glob("lib/**/*") + Dir.glob("bin/**/*") + %w[README.md LICENSE.txt CHANGELOG.md]
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.7"

  s.add_development_dependency "bundler", ">= 1.15"
  s.add_development_dependency "rake", ">= 13.0"
  s.add_development_dependency "rspec", ">= 3.9"
end
