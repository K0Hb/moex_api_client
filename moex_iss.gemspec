# frozen_string_literal: true

require_relative "lib/moex_iss/version"

Gem::Specification.new do |s|
  s.name = "moex_iss"
  s.version = MoexIss::VERSION
  s.authors = ["Vyacheslav Konovalov"]
  s.email = ["goplit2010.konovalov@yandex.ru"]
  s.homepage = "https://github.com/K0Hb/moex_iss"
  s.summary = "Client for MOEX ISS API"

  s.metadata = {
    "bug_tracker_uri" => "https://github.com/K0Hb/moex_iss/issues",
    "changelog_uri" => "https://github.com/K0Hb/moex_iss/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/K0Hb/moex_iss",
    "homepage_uri" => "https://github.com/K0Hb/moex_iss",
    "source_code_uri" => "https://github.com/K0Hb/moex_iss"
  }

  s.license = "MIT"

  s.files = Dir.glob("lib/**/*") + Dir.glob("bin/**/*") + %w[README.md LICENSE.txt CHANGELOG.md]
  s.extra_rdoc_files = ["README.md"]
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.7"

  s.add_development_dependency "bundler", ">= 1.15"
  s.add_development_dependency "rake", ">= 13.0"
  s.add_development_dependency "rspec", ">= 3.9"

  s.add_dependency "faraday", "~> 2.8.1"
  s.add_dependency "zeitwerk", "~> 2.6.1"
end
