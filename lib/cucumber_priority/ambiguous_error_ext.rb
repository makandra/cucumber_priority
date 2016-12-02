module Cucumber
  class Ambiguous

    attr_reader :matches

    def initialize(step_name, matches, *args)
      @matches = matches
      super(step_name, matches, *args)
    end
  end
end
