step_definition_class = Gem::Version.new(Cucumber::VERSION) > Gem::Version.new('3.0') ? Cucumber::Glue::StepDefinition : Cucumber::RbSupport::RbStepDefinition

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
