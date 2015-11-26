module Cucumber
  class Ambiguous

    attr_reader :matches

    def initialize_with_storing_matches(step_name, matches, *args)
      @matches = matches
      initialize_without_storing_matches(step_name, matches, *args)
    end

    alias_method_chain :initialize, :storing_matches

  end
end
