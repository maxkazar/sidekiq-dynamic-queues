# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/dynamic_queues/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-dynamic-queues"
  spec.version       = Sidekiq::DynamicQueues::VERSION
  spec.authors       = ["Max Kazarin"]
  spec.email         = ["maxkazargm@gmail.com"]

  spec.summary       = %q{Sidekiq dynamic queues extension}
  spec.description   = %q{Sidekiq dynamic queues extension}
  spec.homepage      = "https://github.com/maxkazar/sidekiq-delayed"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'sidekiq'
end
