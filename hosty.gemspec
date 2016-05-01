# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "hosty"
  spec.version       = '0.0.1'
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

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.0"

  spec.required_ruby_version = '>= 2.1.0'
end
