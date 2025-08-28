require 'cucumber'

if Gem::Version.new(Cucumber::VERSION) > Gem::Version.new('3.0')
  require 'cucumber/glue/registry_and_more'
else
  require 'cucumber/rb_support/rb_language'
end

