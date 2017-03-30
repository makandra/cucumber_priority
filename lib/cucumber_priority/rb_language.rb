module Cucumber
  module RbSupport
    class RbLanguage

      if method_defined?(:step_matches) || private_method_defined?(:step_matches)
        # Cucumber 2.3 or higher has a single method #step_matches which returns an
        # array of Cucumber::StepMatch objects.
        # This method raises Cucumber::Ambiguous if the array has more than one element.

        def step_matches_with_priority(*args)
          result = step_matches_without_priority(*args)
          resolve_ambiguity_through_priority(result)
        end

        CucumberPriority::Util.alias_chain self, :step_matches, :priority

      end

      private

      def resolve_ambiguity_through_priority(matches)
        overridable, overriding = matches.partition { |match|
          match.step_definition.overridable?
        }
        if overriding.size > 0
          overriding
        elsif overridable.size > 0
          # If we have multiple overridable steps, we use the all
          # with the highest priority.
          overridable.sort_by { |match|
            - match.step_definition.priority
          }
          priority = overridable[-1].step_definition.priority
          overridable.select{|match| match.step_definition.priority == priority}
        else
          matches
        end
      end

    end
  end
end
