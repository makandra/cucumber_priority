step_definition_class = Cucumber::VERSION >= '3' ? Cucumber::Glue::StepDefinition : Cucumber::RbSupport::RbStepDefinition

step_definition_class.class_eval do

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
