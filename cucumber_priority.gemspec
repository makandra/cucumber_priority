# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cucumber_priority/version"

Gem::Specification.new do |spec|
  spec.name = %q{cucumber_priority}
  spec.version = CucumberPriority::VERSION
  spec.authors = ["Henning Koch"]
  spec.email = %q{github@makandra.de}
  spec.homepage = %q{http://github.com/makandra/cucumber_priority}
  spec.summary = %q{Overridable step definitions for Cucumber}
  spec.description = %q{cucumber_priority provides a way to mark step definitions as overridable, meaning that they can always be overshadowed by a more specific version without raising an error.}
  spec.license = 'MIT'
  spec.metadata = {
    'rubygems_mfa_required' => 'true',
    'bug_tracker_uri' => 'https://github.com/makandra/cucumber_priority/issues',
    'changelog_uri' => 'https://github.com/makandra/cucumber_priority/blob/master/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/makandra/cucumber_priority',
  }

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(gemfiles|bin|test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('cucumber')

end
