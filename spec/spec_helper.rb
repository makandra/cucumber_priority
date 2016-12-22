$: << File.join(File.dirname(__FILE__), "/../../lib" )
require 'cucumber_priority'
require 'gemika'

Dir["#{File.dirname(__FILE__)}/support/*.rb"].sort.each {|f| require f}

Gemika::RSpec.configure_should_syntax
