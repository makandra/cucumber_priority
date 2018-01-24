module Cucumber
  module Glue
    class StepDefinition

      def overridable(options = {})
        @overridable = true
        @priority = options[:priority]
        self
      end

      def overridable?
        !!@overridable
      end

      def priority
        @priority ||= 0
      end

    end
  end
end
