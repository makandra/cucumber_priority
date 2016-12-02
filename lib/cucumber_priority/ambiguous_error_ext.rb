module CucumberAmbiguousWithMatches
  attr_reader :matches

  def initialize(step_name, matches, *args)
    @matches = matches
    super(step_name, matches, *args)
  end
end

Cucumber::Ambiguous.prepend CucumberAmbiguousWithMatches
