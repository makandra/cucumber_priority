module Cucumber
  class Ambiguous

    attr_reader :matches

    def initialize_with_storing_matches(step_name, matches, *args)
      @matches = matches
      initialize_without_storing_matches(step_name, matches, *args)
    end

    CucumberPriority::Util.alias_chain self, :initialize, :storing_matches

  end
end
