# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/parser_fw1_loggrabber/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-fw1_loggrabber_parser"
  spec.version       = Fluent::Plugin::Fw1LoggrabberParser::VERSION
  spec.authors       = ["Tomoyuki Sugimura"]
  spec.email         = ["tomoyuki.sugimura@gmail.com"]

  spec.summary       = %q{parse checkpoint firewall-1 LEA formatted log}
  spec.description   = %q{parse checkpoint firewall-1 LEA formatted log from file}
  spec.homepage      = "https://localhost.localdomain"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  #if spec.respond_to?(:metadata)
  #  spac.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency "fluentd", "~> 0.10", ">= 0.10.43"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "test-unit"
end
