# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hosty/version'

Gem::Specification.new do |spec|
  spec.name          = "hosty"
  spec.version       = Hosty::VERSION
  spec.authors       = ["Shintaro Kojima"]
  spec.email         = ["goodies@codeout.net"]

  spec.summary       = "/etc/hosts based tiny reverse proxy."

  spec.description   = <<-EOS
/etc/hosts based tiny reverse proxy.

You may sometimes run a web application on http://localhost:3000 during development, or
sometimes you may configure local port forward on http://localhost:8080 with SSH to access web servers behind firewalls.

Hosty loads your /etc/hosts and acts as a reverse proxy to simplify the URLs.
It allows you to manage mappings of local server name and port on /etc/hosts.
                       EOS

  spec.homepage      = "https://github.com/codeout/hosty"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rack-reverse-proxy"
  spec.add_runtime_dependency "rackup"
  spec.add_runtime_dependency "webrick"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
end
