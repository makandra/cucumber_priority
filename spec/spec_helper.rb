# encoding: utf-8

$: << File.join(File.dirname(__FILE__), "/../../lib" )
require 'cucumber_priority'

if defined?(RSpec)
  RSpec.configure do |config|
    if config.respond_to?(:expect_with)
      config.expect_with(:rspec) do |c|
        c.syntax = [:expect, :should]
      end
    end
  end
end