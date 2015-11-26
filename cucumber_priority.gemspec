# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cucumber_priority/version"

Gem::Specification.new do |s|
  s.name = %q{cucumber_priority}
  s.version = CucumberPriority::VERSION
  s.authors = ["Henning Koch"]
  s.email = %q{github@makandra.de}
  s.homepage = %q{http://github.com/makandra/cucumber_priority}
  s.summary = %q{Overridable step definitions for Cucumber}
  s.description = %q{cucumber_priority provides a way to mark step definitions as overridable, meaning that they can always be overshadowed by a more specific version without raising an error.}
  s.license = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('cucumber')
  s.add_dependency('activesupport')

end
