# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/time_zone_header/version"

Gem::Specification.new do |s|
  s.name        = "rack-time-zone-header"
  s.version     = Rack::TimeZoneHeader::VERSION::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Randy Reddig", "Cameron Walters"]
  s.email       = "github@squareup.com"
  s.homepage    = "https://github.com/square/rack-time-zone-header"
  s.summary     = %q{Rack middleware for Time-Zone HTTP headers}
  s.description = %q{Allow web service clients to specify the request time zone in an HTTP header.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.extra_rdoc_files = ['README.rdoc', 'HISTORY.rdoc', 'LICENSE.txt']
  s.require_paths = ["lib"]

  s.add_dependency 'rack', '~> 1.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'tzinfo', '>= 0.3.14'
  s.add_development_dependency 'rack-test', '~> 0.5'
  s.add_development_dependency 'rspec', '~> 2.6'
end
