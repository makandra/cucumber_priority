module Cucumber
  module StepMatchSearch
    class AssertUnambiguousMatch

      def call_with_priority(*args)
        call_without_priority(*args)
      rescue Ambiguous => e
        resolve_ambiguity_through_priority(e)
      end

      CucumberPriority::Util.alias_chain self, :call, :priority

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
