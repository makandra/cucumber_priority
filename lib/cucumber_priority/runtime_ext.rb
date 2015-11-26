module Cucumber
  class Ambiguous

    attr_reader :matches

    def initialize_with_storing_matches(step_name, matches, *args)
      @matches = matches
      initialize_without_storing_matches(step_name, matches, *args)
    end

    alias_method_chain :initialize, :storing_matches

  end

  (defined?(Runtime) ? Runtime : StepMother).class_eval do

    def step_match_with_priority(*args)
      step_match_without_priority(*args)
    rescue Ambiguous => e
      overridable, overriding = e.matches.partition { |match|
        match.step_definition.overridable?
      }
      if overriding.size > 1
        # If we have more than one overriding step definitions,
        # this is an ambiguity error
        raise
      elsif overriding.size == 1
        # If our ambiguity is due to another overridable step,
        # we can use the overriding step
        overriding.first
      elsif overriding.size == 0
        # If we have multiple overridable steps, we use the one
        # with the highest priority.
        overridable.sort_by { |match|
          match.step_definition.priority
        }.last
      end
    end

    alias_method_chain :step_match, :priority

  end
end
