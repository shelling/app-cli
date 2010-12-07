# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "app-cli/version"

Gem::Specification.new do |s|
  s.name        = "app-cli"
  s.version     = App::CLI::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["shelling"]
  s.email       = ["navyblueshellingford@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{framework for creating CLI tool set}
  s.description = %q{framework for creating CLI tool set}

  s.rubyforge_project = "app-cli"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
