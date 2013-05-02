# -*- encoding: utf-8 -*-
require File.expand_path('../lib/spot_rate/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeff Iacono"]
  gem.email         = ["jeff.iacono@gmail.com"]
  gem.description   = %q{get current currency spot rates with ruby}
  gem.summary       = %q{current currency spot rates}
  gem.homepage      = "https://github.com/jeffreyiacono/spot-rate"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "spot-rate"
  gem.require_paths = ["lib"]
  gem.version       = SpotRate::VERSION

  gem.add_runtime_dependency "net-sftp"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "cane"
  gem.add_development_dependency "rspec", [">= 2"]
end
