def prepare_cucumber_example
  @runtime = Cucumber::Runtime.new
  scenario = double('scenario', :language => 'en', :accept_hook? => true)
  @runtime.send(:begin_scenario, scenario)
  @main = Object.new
  @main.extend(Cucumber::Glue::Dsl)
  # @runtime.before(scenario)
end

def invoke_cucumber_step(step)
  first_step_match(step).invoke(nil) # nil means no multiline args
end

def support_code
  @runtime.instance_variable_get(:@support_code)
end

def first_step_match(*args)
  support_code.send(:step_matches, *args).first
end
