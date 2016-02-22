module Cucumber
  class Runtime
    class SupportCode

      if method_defined?(:step_matches) || private_method_defined?(:step_matches)
        # Cucumber 2.3 or higher has a single method #step_matches which returns an
        # array of Cucumber::StepMatch objects.
        # This method raises Cucumber::Ambiguous if the array has more than one element.

        def step_matches_with_priority(*args)
          step_matches_without_priority(*args)
        rescue Ambiguous => e
          resolve_ambiguity_through_priority(e)
        end

        alias_method_chain :step_matches, :priority

      else
        # Cucumber 2.1 or lower has a single method #step_match which returns a
        # single Cucumber::StepMatch.
        # This method raises Cucumber::Ambigiuous if there are two or more matches.

        def step_match_with_priority(*args)
          step_match_without_priority(*args)
        rescue Ambiguous => e
          resolve_ambiguity_through_priority(e).first
        end

        alias_method_chain :step_match, :priority

        # This method doesn't exist in old Cucumbers.
        # We define it so our specs have a unified API to match steps.
        def step_matches(*args)
          [step_match(*args)]
        end

      end

      private

      def resolve_ambiguity_through_priority(e)
        overridable, overriding = e.matches.partition { |match|
          match.step_definition.overridable?
        }
        if overriding.size > 1
          # If we have more than one overriding step definitions,
          # this is an ambiguity error
          raise e
        elsif overriding.size == 1
          # If our ambiguity is due to another overridable step,
          # we can use the overriding step
          overriding
        elsif overriding.size == 0
          # If we have multiple overridable steps, we use the one
          # with the highest priority.
          overridable.sort_by { |match|
            - match.step_definition.priority
          }
        end
      end

    end
  end
end
