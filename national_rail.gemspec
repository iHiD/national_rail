# -*- encoding: utf-8 -*-
require File.expand_path('../lib/national_rail/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Walker"]
  gem.email         = ["jez.walker@gmail.com"]
  gem.description   = %q{A library for accessing National Rail data}
  gem.summary       = %q{Converts the output from the National Rail SOAP to something sane!}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "national_rail"
  gem.require_paths = ["lib"]
  gem.version       = NationalRail::VERSION
  
  gem.add_dependency('savon')
end
